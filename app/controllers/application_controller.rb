class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_current_team
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  layout :set_layout


  private
  def set_current_team
    if params[:team_slug].present?
      team = Team.friendly.find(params[:team_slug])
      set_current_tenant(team)
    else
      # Handle cases where team_slug is not present?
    end
  end
  def set_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end
end
