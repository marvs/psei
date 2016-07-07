class Psei::Day
  SOURCE_URL = "http://pse.com.ph/stockMarket/home.html?method=getSecuritiesAndIndicesForPublic&ajax=true"
  attr_reader :parsed
  
  def initialize
    @parsed = Psei::Parser.new(SOURCE_URL).process
  end
  
  def value symbol
    stock = find_by_symbol symbol
    stock['lastTradedPrice'].to_f
  end
  
  private
  
  def find_by_symbol symbol
    @parsed.detect{ |s| s['securitySymbol'] == symbol.to_s }
  end
  
end
