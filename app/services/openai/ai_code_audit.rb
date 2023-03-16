require 'uri'
require "json"
require 'net/http'

module Openai
  class AiCodeAudit
    def initialize(token, code)
      @token = token
      @code = code
    end

    def run
      url = URI("https://api.openai.com/v1/completions")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{@token}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump({
                        "model": "code-davinci-002",
                        "prompt": "#{@code}",
                        "max_tokens": 64,
                        "temperature": 0.5
                      })

      response = https.request(request)
      JSON.parse(response.body)
    end
  end
end
