Facebook::Messenger.configure do |config|
  config.access_token = ENV["FB_ACCESS_TOKEN"]
  config.app_secret   = ENV["FB_APP_SECRET"]
  config.verify_token = ENV["FB_VERIFY_TOKEN"]
end

unless Rails.env.production?
  bot_files = Dir[Rails.root.join("app", "bot", "**", "*.rb")]
  bots_reloader = ActiveSupport::FileUpdateChecker.new(bot_files) do
    bot_files.each{ |file| require_dependency file }
  end

  ActionDispatch::Callbacks.to_prepare do
    bots_reloader.execute_if_updated
  end

  bot_files.each { |file| require_dependency file }
end