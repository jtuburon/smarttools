# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_smarttools_session'
#Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes

Rails.application.config.session_store :iron_cache, project_id: ENV['IRON_PROJECTID'], token: ENV['IRON_TOKEN'], expires_in: 7200