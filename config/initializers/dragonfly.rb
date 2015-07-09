require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "fce7984a6e14275650de4c6eb71534508bc4c1b04a4d84ac20f2d7eedbfba5ce"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
