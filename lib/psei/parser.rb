require 'net/http'
require 'json'

class Psei::Parser
  attr_reader :url
  
  def initialize url
    @url = url
  end
  
  def process
    response = get_response
    JSON.parse(response)
  end
  
  private
  
  def get_response
    uri = URI(@url)
    Net::HTTP.get(uri)
  end
  
end
