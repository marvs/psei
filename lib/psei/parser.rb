require 'net/http'
require 'json'

class Psei::Parser
  attr_reader :url
  
  def initialize url
    @url = url
  end
  
  def process(response=nil)
    resp = response || get_response
    JSON.parse(resp)
  end
  
  private
  
  def get_response
    uri = URI(@url)
    @response ||= Net::HTTP.get(uri)
  end
  
end
