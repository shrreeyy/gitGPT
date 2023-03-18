require 'uri'
require "json"
require 'net/http'

module Openai
  class AiCodeAudit
    def initialize(token, content)
      @token = token
      @content = content
    end

    def run
      url = URI("https://api.openai.com/v1/chat/completions")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{@token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content": "#{@content}"
          }
        ]
      })

      response = https.request(request)
      JSON.parse(response.body)
    end
  end
end
