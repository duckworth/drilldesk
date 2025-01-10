class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_team_unauthenticated
  around_action :set_request_id
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  layout :set_layout

  private

  def set_team_unauthenticated
    if params[:team_slug].present?
      team = Team.friendly.find(params[:team_slug])
      set_current_tenant(team)
    end
    # Handle cases where team_slug is not present?
  end

  def set_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def set_request_id
    # Get the request UUID from Rails/Rack
    Current.request_id = request.uuid
    yield # Always ensure the action will execute
  ensure
    Current.request_id = nil
  end
end
