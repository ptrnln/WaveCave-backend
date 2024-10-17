# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.production?
      origins "https://ph4se.dev", "https://www.ph4se.dev", "http://127.0.0.1*", "http://localhost:*"
      resource "/session/",
        headers: ['Content-Type'],
        methods: [ :get, :post, :delete, :options ],
        credentials: true
      resource "*",
        headers: ['Content-Type'],
        methods: [:get, :post, :put, :patch, :delete, :head],
        credentials: true
    else
      origins "*"
      resource "*", headers: :any, methods: [:get, :post, :patch, :put, :delete]
    end
  end
end
