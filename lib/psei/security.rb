class Psei::Security
  SOURCE_URL = "http://pse.com.ph/stockMarket/home.html?method=getSecuritiesAndIndicesForPublic&ajax=true"
  HEADING_ALIAS = "Stock Update As of"
  INDEX_ALIASES = ["PSEi", "All Shares", "Financials", "Industrial", "Holding Firms", "Property", "Services", "Mining and Oil"].freeze
  attr_reader :parsed
  
  def initialize
    @parsed = Psei::Parser.new(SOURCE_URL).process
  end
  
  # Returns a Hash of last traded prices per security
  def values
    securities_hash
  end
  
  # Returns the last traded price of a specific security
  def value symbol
    values[symbol.to_s]
  end
  
  def date
    Psei::Date.new(@parsed).get
  end
  
  private
  
  def find_by_symbol symbol
    securities = securities_filter
    securities.detect{ |s| s['securitySymbol'] == symbol.to_s }
  end
  
  def securities_filter
    @parsed.reject{|x| (INDEX_ALIASES).include?(x['securityAlias']) || x['securitySymbol'] == HEADING_ALIAS}
  end
  
  def securities_hash
    @sec_hash ||= Hash[securities_filter.collect{|item| [item['securitySymbol'], item['lastTradedPrice'].to_f] }]
  end
  
end
