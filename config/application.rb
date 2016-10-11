require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load configuration
Dotenv.load("#{Rails.root}/.env")

module SimpleBot
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Auto-load /bot and its subdirectories
    config.paths.add File.join("app", "bot"), glob: File.join("**", "*.rb")
    config.autoload_paths += Dir[Rails.root.join("app", "bot", "*")]
  end
end
