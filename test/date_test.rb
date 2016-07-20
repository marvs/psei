require 'test_helper'

describe Psei::Date do
  let(:timestamp) { "10/20/2016 03:20 PM" }
  let(:date_hash) { {"lastTradedPrice" => "DATE", 
                    "securityAlias" => timestamp, 
                    "securitySymbol" => "Stock Update As of"} }
  let(:security_hash) { {"totalVolume"=>"81,800", 
                        "indicator"=>"D", 
                        "percChangeClose"=>"-0.68", 
                        "lastTradedPrice"=>"7.28", 
                        "securityAlias"=>"Test Security", 
                        "indicatorImg"=>"", 
                        "securitySymbol"=>"TST" } }
  let(:sample) { [date_hash, security_hash] }                      
                        
  before do
    @date = Psei::Date.new(sample)
  end

  describe "#get" do
    it "returns the correct date" do
      @date.get.must_equal Date.parse('2016-10-20')
    end
  end
  
  describe "#get_datetime" do
    it "returns the correct hour" do
      @date.get_datetime.hour.must_equal 15
    end
    
    it "returns the correct minute" do
      @date.get_datetime.minute.must_equal 20
    end
  end
end
