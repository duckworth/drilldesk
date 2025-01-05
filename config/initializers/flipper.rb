Rails.application.config.after_initialize do
  Flipper::UI.configure do |config|
    config.application_breadcrumb_href = "/admin"
  end
end
