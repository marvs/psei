# Based on the parsed request, gets the date of the values
class Psei::Date
  DATE_IDENTIFIER = "DATE"
  DATETIME_FORMAT = '%m/%d/%Y %H:%M %p%z'
  
  def initialize parsed
    @parsed = parsed
    @parsed_time = nil
  end
  
  def get
    parse_time.to_date
  end
  
  def get_datetime
    parse_time
  end
  
  private
  
  def date_filter
    @parsed.select{|x| x["lastTradedPrice"] == DATE_IDENTIFIER}.first
  end
  
  def date_string
    date_str = date_filter["securityAlias"]
    date_str << "+0800"
  end
  
  def parse_time
    @parsed_time ||= DateTime.strptime(date_string, DATETIME_FORMAT)
  end
end
