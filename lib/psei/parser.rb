require 'net/http'
require 'json'

class Psei::Parser
  attr_reader :url
  
  def initialize url, headers
    @url = url
    @headers = headers
  end
  
  def process(response=nil)
    resp = response || get_response
    JSON.parse(resp)
  end
  
  private
  
  def get_response
    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Get.new(uri.request_uri)
    @headers.keys.each do |k|
      request[k.to_s] = @headers[k]
    end

    @response ||= http.request(request).body
  end
  
end
