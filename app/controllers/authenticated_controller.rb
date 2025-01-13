# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ActsAsTenant::ControllerExtensions::Filter
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  before_action :set_team_and_membership
  after_action :reset_current

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_team_and_membership
    @membership = if session[:current_team_id].present?
                    # Load a specific membership and associated team from the session team_id
                    current_user.memberships.includes(:team).find_by(team_id: session[:current_team_id])
    else
                    # Lazy-load user's memberships with their associated teams
                    memberships = current_user.memberships.includes(:team).limit(2).to_a

                    if memberships.size == 1
                      # If the user has exactly one membership, use it
                      session[:current_team_id] = memberships.first.team_id
                      memberships.first
                    else
                      # Redirect if no session is set and multiple teams exist
                      return redirect_to choose_team_path
                    end
    end

    if @membership
      # Populate necessary instance variables and tenant context
      @team = @membership.team
      set_current_tenant(@team)
      Current.team = @team
      Current.membership = @membership
      Current.user = current_user
    else
      # Handle the edge case where the specified team is invalid or unauthorized
      flash[:alert] = "You are not authorized or the selected team does not exist."
      logger.warn "User #{current_user.id} attempted to access team (id=#{session[:current_team_id]}) without permission."
      session[:current_team_id] = nil
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
