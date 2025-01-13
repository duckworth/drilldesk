class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_request_id
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  layout :set_layout

  private

  def set_layout
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def set_request_id
    Current.request_id = request.uuid
  end
end
