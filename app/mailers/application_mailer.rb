class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.config.app_settings.mailer_sender
  layout "mailer"
end
