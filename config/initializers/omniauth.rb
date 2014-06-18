OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, CONFIG[:app_id], CONFIG[:app_secret],{:provider_ignores_state => true, scope: "user_events" } 
end
