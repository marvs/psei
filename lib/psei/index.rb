class Psei::Index
  SOURCE_URL = "http://pse.com.ph/stockMarket/home.html?method=getSecuritiesAndIndicesForPublic&ajax=true"
  HEADING_ALIAS = "Stock Update As of"
  INDEX_ALIASES = ["PSEi", "All Shares", "Financials", "Industrial", "Holding Firms", "Property", "Services", "Mining and Oil"].freeze
  attr_reader :parsed
  
  def initialize
    @parsed = Psei::Parser.new(SOURCE_URL).process
  end
  
  # Returns a Hash of last values of indices
  def values
    indices
  end
  
  # Returns the last value of an index
  def value symbol
    values[symbol.to_s]
  end
  
  def date
    Psei::Date.new(@parsed).get
  end
  
  private
  
  def find_by_symbol symbol
    indices = indices_filter
    indices.detect{ |s| s['securitySymbol'] == symbol.to_s }
  end
  
  def indices_filter
    @parsed.select{|x| (INDEX_ALIASES).include?(x['securityAlias']) && x['securitySymbol'] != HEADING_ALIAS}
  end
  
  def indices
    @ind_hash ||= Hash[indices_filter.collect{|item| [item['securitySymbol'], item['lastTradedPrice'].to_f] }]
  end
  
end
