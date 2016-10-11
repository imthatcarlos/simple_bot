require "faraday"
require "json"

module Facebook
  class Client
    def initialize
      @base_url = "https://graph.facebook.com/v2.8"
    end

    def exchange_tokens
      options = {
        grant_type:        "fb_exchange_token",
        client_id:         ENV["FB_APP_ID"],
        client_secret:     ENV["FB_APP_SECRET"],
        fb_exchange_token: ENV["FB_ACCESS_TOKEN"]
      }

      get("/oauth/access_token", options)
    end

    def get_user(fb_id)
      JSON.load(get("#{fb_id}", { access_token: ENV["FB_ACCESS_TOKEN"] }))
    end

    def set_typing_on(fb_id)
      body = {
        recipient: { id: fb_id },
        sender_action: "typing_on"
      }
      post("me/messages?access_token=#{ENV['FB_ACCESS_TOKEN']}", body)
    end

    def set_typing_off(fb_id)
      body = {
        recipient: { id: fb_id },
        sender_action: "typing_off"
      }
      post("me/messages?access_token=#{ENV['FB_ACCESS_TOKEN']}", body)
    end

    private

    def post(path, body)
      conn = Faraday.new(@base_url)
      conn.post do |req|
        req.url path
        req.headers["Content-Type"] = "application/json"
        req.body = "#{body}"
      end
    end

    def get(path, options = {})
      conn = Faraday.new(@base_url)
      resp = conn.get(path, options)
      resp.body
    end
  end
end