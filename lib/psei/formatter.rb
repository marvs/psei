# Formats the parsed data
class Psei::Formatter
  
  def initialize
    @arr = []
  end
  
  def process arr
    @arr = arr
    @arr ? to_hash : {}
  end
  
  private
  
  def int_format val
    val.to_s.gsub(',', '').to_i
  end
  
  def float_format val
    val.to_s.gsub(',','').to_f
  end
  
  def get_total_volume
    float_format @arr['totalVolume']
  end
  
  def get_percent_change
    float_format @arr['percChangeClose']
  end
  
  def get_last_price
    float_format @arr['lastTradedPrice']
  end
  
  def up_or_down
    @arr['indicator'] == "U" ? 'up' : 'down'
  end
  
  def to_hash
    { 
      symbol: @arr['securitySymbol'],
      alias: @arr['securityAlias'],
      total_volume: get_total_volume,
      updown: up_or_down,
      percent_change: get_percent_change,
      last_price: get_last_price
    }
  end
end
