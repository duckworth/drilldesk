class TenantController < AuthenticatedController
  before_action :set_current_team

  private

  def set_current_team
    if params[:team_slug].present?
      team = Team.friendly.find(params[:team_slug])
      set_current_tenant(team)
    end
  end
end
