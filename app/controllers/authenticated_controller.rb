# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include TeamControllerMethods
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :set_team_and_membership
  after_action :reset_current
  before_action :set_paper_trail_whodunnit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end
end
