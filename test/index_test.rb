require 'test_helper'

describe Psei::Index do
  let(:index_1_symbol) { "FIN" }
  let(:index_2_symbol) { "IND" }
  let(:timestamp) { "10/20/2016 03:20 PM" }
  let(:date_hash) { {"lastTradedPrice" => "DATE", 
                    "securityAlias" => timestamp, 
                    "securitySymbol" => "Stock Update As of"} }
  let(:index_1_hash) { {"totalVolume"=>"81,800", 
                        "indicator"=>"D", 
                        "percChangeClose"=>"-0.68", 
                        "lastTradedPrice"=>"7.28", 
                        "securityAlias"=>"Financials", 
                        "indicatorImg"=>"", 
                        "securitySymbol"=>index_1_symbol } }
  let(:index_2_hash) { {"totalVolume"=>"62,800", 
                        "indicator"=>"U", 
                        "percChangeClose"=>"1.60", 
                        "lastTradedPrice"=>"10.45", 
                        "securityAlias"=>"Industrial", 
                        "indicatorImg"=>"", 
                        "securitySymbol"=>index_2_symbol } }                      
  let(:sample) { [date_hash, index_1_hash, index_2_hash] }
  let(:parser) { Minitest::Mock.new }

  before do
    parser.expect :process, sample
    @index = Psei::Index.new(parser)
  end

  describe "#symbols" do
    it "returns all symbols" do
      @index.symbols.must_equal [index_1_symbol, index_2_symbol]
    end
  end
  
  describe "#values" do
    it "returns all indices" do
      @index.values.size.must_equal 2
    end
    
    it "returns the first index" do
      @index.values[0][:symbol].must_equal index_1_symbol
    end
    
    it "returns the second index" do
      @index.values[1][:symbol].must_equal index_2_symbol
    end
  end
  
  describe "#value" do
    before do
      @value = @index.value(index_1_symbol)
    end
  
    it "returns the correct index" do
      @value[:symbol].must_equal index_1_symbol
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
      @index.date.must_be_kind_of Date
    end
    
    it "returns the correct date" do
      @index.date.must_equal Date.parse("2016-10-20")
    end
  end
end
