require 'uri'
require 'net/http'

module Git
  class PullRequest
    def initialize(token, username, repo_name)
      @token = token
      @owner = username
      @repo = repo_name
    end

    def run
      url = URI("https://api.github.com/repos/#{@owner}/#{@repo}/pulls")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Accept"] = "application/vnd.github+json"
      request["X-GitHub-Api-Version"] = "2022-11-28"
      request["Authorization"] = "Bearer #{@token}"

      response = https.request(request)
      JSON.parse(response.body)
    end
  end
end
