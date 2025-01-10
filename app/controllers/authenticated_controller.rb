# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  skip_before_action :set_team_unauthenticated
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  before_action :set_team_and_membership
  after_action :reset_current

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_team_and_membership
    return if params[:team_slug].blank?

    # Attempt to find membership + team in one query
    @membership = current_user.memberships
                              .includes(:team)
                              .find_by(teams: { slug: params[:team_slug] })

    if @membership
      @team = @membership.team
      set_current_tenant(@team)
      Current.team = @team
      Current.membership = @membership
      Current.user = current_user
    else
      # This means either the team doesn't exist or
      # the current_user is not part of that team.
      # handle gracefully (404 or redirect)
      flash[:alert] = "You are not authorized."
      logger.warn "User #{current_user.id} attempted to access team #{params[:team_slug]} without permission."
      redirect_to root_path
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def reset_current
    Current.user = nil
    Current.team = nil
    Current.membership = nil
  end
end
