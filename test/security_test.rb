require 'test_helper'

describe Psei::Formatter do
  let(:security_1_symbol) { "TST1" }
  let(:security_2_symbol) { "TST2" }
  let(:timestamp) { "10/20/2016 03:20 PM" }
  let(:date_hash) { {"lastTradedPrice" => "DATE", 
                    "securityAlias" => timestamp, 
                    "securitySymbol" => "Stock Update As of"} }
  let(:security_1_hash) { {"totalVolume"=>"81,800", 
                        "indicator"=>"D", 
                        "percChangeClose"=>"-0.68", 
                        "lastTradedPrice"=>"7.28", 
                        "securityAlias"=>"Test Security 1", 
                        "indicatorImg"=>"", 
                        "securitySymbol"=>security_1_symbol } }
  let(:security_2_hash) { {"totalVolume"=>"62,800", 
                        "indicator"=>"U", 
                        "percChangeClose"=>"1.60", 
                        "lastTradedPrice"=>"10.45", 
                        "securityAlias"=>"Test Security 2", 
                        "indicatorImg"=>"", 
                        "securitySymbol"=>security_2_symbol } }                      
  let(:sample) { [date_hash, security_1_hash, security_2_hash] }
  let(:parser) { Minitest::Mock.new }

  before do
    parser.expect :process, sample
    @security = Psei::Security.new(parser)
  end

  describe "#symbols" do
    it "returns all symbols" do
      @security.symbols.must_equal [security_1_symbol, security_2_symbol]
    end
  end
  
  describe "#values" do
    it "returns all securities" do
      @security.values.size.must_equal 2
    end
    
    it "returns the first security" do
      @security.values[0][:symbol].must_equal security_1_symbol
    end
    
    it "returns the second security" do
      @security.values[1][:symbol].must_equal security_2_symbol
    end
  end
  
  describe "#value" do
    before do
      @value = @security.value(security_1_symbol)
    end
  
    it "returns the correct security" do
      @value[:symbol].must_equal security_1_symbol
    end
    
    it "returns the last traded price" do
      @value[:last_price].wont_be_nil
    end
    
    it "returns the volume" do
      @value[:total_volume].wont_be_nil
    end
    
    it "returns the percentage change" do
      @value[:percent_change].wont_be_nil
    end
    
    it "returns whether it is up or down" do
      @value[:updown].must_equal "down"
    end
  end
  
  describe "#date" do
    it "returns a Date" do
      @security.date.must_be_kind_of Date
    end
    
    it "returns the correct date" do
      @security.date.must_equal Date.parse("2016-10-20")
    end
  end
end
