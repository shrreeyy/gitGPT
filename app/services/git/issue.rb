require 'uri'
require 'net/http'

module Git
  class Issue
    def initialize(token, username, repo_name)
      @token = token
      @owner = username
      @repo = repo_name
    end

    def run(title, description)
      url = URI("https://api.github.com/repos/#{@owner}/#{@repo}/issues")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Accept"] = "application/vnd.github+json"
      request["X-GitHub-Api-Version"] = "2022-11-28"
      request["Authorization"] = "Bearer #{@token}"
      request.body = JSON.dump({
        "title": "#{title}",
        "body": "#{description}"
      })

      response = https.request(request)
      JSON.parse(response.body)
    end
  end
end
