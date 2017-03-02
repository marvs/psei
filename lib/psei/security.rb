class Psei::Security
  
  def initialize(headers={}, parser=nil)
    @parser = parser || Psei::Parser.new(Psei::SOURCE_URL, headers)
    @parsed = @parser.process
    @formatter = Psei::Formatter.new
  end
  
  def symbols
    securities_hash.keys
  end
  
  def values
    symbols.collect{ |x| value x }
  end
  
  # Returns the data of a  specific security
  def value symbol
    security symbol
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
    @sec_filter ||= @parsed.reject do |x| 
      (Psei::INDEX_ALIASES).include?(x['securityAlias']) || x['securitySymbol'] == Psei::HEADING_ALIAS
    end
  end
  
  def securities_hash
    @sec_hash ||= Hash[securities_array]
  end
  
  def securities_array
    @sec_array ||= securities_filter.collect do |item| 
      [item['securitySymbol'], item['lastTradedPrice'].to_f]
    end
  end
  
  def security sym
    sec = securities_filter.select{|x| x['securitySymbol'] == sym }.first
    @formatter.process sec
  end
  
end
