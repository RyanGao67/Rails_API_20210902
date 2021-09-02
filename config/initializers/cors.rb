Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:3000" # react application
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :option, :head], credentials: true
  end

  allow do
    origins "http://jdh-authentication-app-react.herokuapp.com" # react application
    resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :option, :head], credentials: true
  end
end