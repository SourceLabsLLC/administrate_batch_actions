Rails.application.configure do
  config.enable_reloading = false if config.respond_to?(:enable_reloading=)
  config.consider_all_requests_local = true
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :stderr
end
