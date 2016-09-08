require 'test_helper'

describe Psei::Formatter do
  let(:sample) { {"totalVolume"=>"81,800", 
                  "indicator"=>"D", 
                  "percChangeClose"=>"-0.68", 
                  "lastTradedPrice"=>"7.28", 
                  "securityAlias"=>"Test Security", 
                  "indicatorImg"=>"", 
                  "securitySymbol"=>"TST" } }        

  before do
    @formatted = Psei::Formatter.new.process(sample)
  end

  describe "#process" do
    describe "total volume" do
      it "returns the correct value" do
        @formatted[:total_volume].must_equal 81800
      end
      
      it "returns the correct type" do
        @formatted[:total_volume].must_be_kind_of Float
      end
    end
    
    describe "percent change" do
      it "returns the correct value" do
        @formatted[:percent_change].must_equal -0.68
      end
      
      it "returns the correct type" do
        @formatted[:percent_change].must_be_kind_of Float
      end
    end
    
    describe "last price" do
      it "returns the correct value" do
        @formatted[:last_price].must_equal 7.28
      end
      
      it "returns the correct type" do
        @formatted[:last_price].must_be_kind_of Float
      end
    end
    
    describe "up or down" do
      it "returns up" do
        sample["indicator"] = "U"
        formatted_up = Psei::Formatter.new.process(sample)
        formatted_up[:updown].must_equal "up"
      end
      
      it "returns down" do
        @formatted[:updown].must_equal "down"
      end
    end
    
    describe "symbol" do
      it "returns the same symbol" do
        @formatted[:symbol].must_equal sample["securitySymbol"]
      end
    end
    
    describe "alias" do
      it "returns the same alias" do
        @formatted[:alias].must_equal sample["securityAlias"]
      end
    end
  end
end
