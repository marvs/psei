class Psei::Index
  
  def initialize
    @parsed = Psei::Parser.new(Psei::SOURCE_URL).process
    @formatter = Psei::Formatter.new
  end
  
  def symbols
    indices_hash.keys
  end
  
  # Returns a Hash of last values of indices
  def values
    symbols.collect{ |x| value x }
  end
  
  # Returns the last value of an index
  def value symbol
    index symbol
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
    @parsed.select do |x| 
      (Psei::INDEX_ALIASES).include?(x['securityAlias']) && x['securitySymbol'] != Psei::HEADING_ALIAS
    end
  end
  
  def indices_hash
    @ind_hash ||= Hash[indices_array]
  end
  
  def indices_array
    @ind_array ||= indices_filter.collect do |item| 
      [item['securitySymbol'], item['lastTradedPrice'].to_f]
    end
  end
  
  def index sym
    ind = indices_filter.select{|x| x['securitySymbol'] == sym }.first
    @formatter.process ind
  end
  
end
