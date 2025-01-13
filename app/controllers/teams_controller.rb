class TeamsController < ApplicationController
  before_action :authenticate_user!
  def index
    @pagy, @teams = pagy current_user.teams.order(:name)
  end

  def choose
    team = current_user.teams.friendly.find(params[:id])
    user = current_user
    # Reset the session to invalidate old CSRF tokens.
    reset_session
    bypass_sign_in(user)
    session[:current_team_id] = team.id
    redirect_to dashboard_index_path, notice: "You have selected #{team.name}."
  end
end
