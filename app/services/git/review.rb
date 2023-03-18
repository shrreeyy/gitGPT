require 'uri'
require 'net/http'

module Git
  class Review
    def initialize(token, username, repo_name, number)
      @token = token
      @owner = username
      @repo = repo_name
      @number = number
    end

    def run(body, commit_id, path)
      url = URI("https://api.github.com/repos/#{@owner}/#{@repo}/pulls/#{@number}/comments")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Accept"] = "application/vnd.github+json"
      request["X-GitHub-Api-Version"] = "2022-11-28"
      request["Authorization"] = "Bearer #{@token}"
      request.body = JSON.dump({
        "body": "#{body}",
        "commit_id": "#{commit_id}",
        "path": "#{path}",
        "line": 1
      })

      response = https.request(request)
      JSON.parse(response.body)
    end
  end
end
