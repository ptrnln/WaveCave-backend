# config/initializers/session_store.rb

Rails.application.config.session_store :cookie_store,
  key: '_wave_cave_session',
  domain: Rails.env.production? ? '.ph4se.dev' : nil,
  same_site: Rails.env.production? ? :none : :lax,
  secure: Rails.env.production?,
  httponly: true
