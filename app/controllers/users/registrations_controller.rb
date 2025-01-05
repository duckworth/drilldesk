class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_registration_enabled, only: [ :new, :create ]

  private

  def check_registration_enabled
    unless Flipper.enabled?(:registration)
      redirect_to root_path, alert: "User registration is currently disabled."
    end
  end
end
