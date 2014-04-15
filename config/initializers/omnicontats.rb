require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "68175189640.apps.googleusercontent.com", "Au4s9SN__iFv6Y7-AvFPIxb_", {:redirect_path => "/oauth2callback"}
end