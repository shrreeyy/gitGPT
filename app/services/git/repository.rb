require 'uri'
require 'net/http'

module Git
  class Repository
    BASE_URL = 'https://api.github.com'
    API_VERSION = '2022-11-28'
    HEADERS = {
    'Accept' => 'application/vnd.github+json',
    'X-GitHub-Api-Version' => API_VERSION
    }.freeze

    def initialize(token)
      @token = token
    end

    def run
      url = URI("#{BASE_URL}/user/repos")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request.headers = HEADERS
      request['Authorization'] = "Bearer #{@token}"

      response = https.request(request)
      JSON.parse(response.body)
    end
  end
end
