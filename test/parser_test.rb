require 'test_helper'

describe Psei::Parser do
  let(:url)             { 'http://marvs.me' }
  let(:headers)         { {} }
  let(:date_indicator)  { "DATE" }
  let(:datetime)        { "07/22/2016 03:20 PM" }
  let(:security_symbol) { "TEL" }
  let(:index_symbol)    { "M-O" }
  let(:sample)          { "[{\"totalVolume\":\"\",\"indicator\":\"U\",\"percChangeClose\":\"\",\"lastTradedPrice\":\"#{date_indicator}\",\"securityAlias\":\"#{datetime}\",\"indicatorImg\":\"<img src='/styles/pse/images/icons/upChange.png' width='15' height='12' hspace='100' vspace='-15'>\",\"securitySymbol\":\"Stock Update As of\"},{\"totalVolume\":\"130,500\",\"indicator\":\"D\",\"percChangeClose\":\"-0.27\",\"lastTradedPrice\":\"7.48\",\"securityAlias\":\"PLDT\",\"indicatorImg\":\"\",\"securitySymbol\":\"#{security_symbol}\"},{\"totalVolume\":\"11,242.05\",\"indicator\":\"U\",\"percChangeClose\":\"0.71\",\"lastTradedPrice\":\"79.02\",\"securityAlias\":\"Mining and Oil\",\"indicatorImg\":\"<img src='/styles/pse/images/icons/upChange.png' width='15' height='12' hspace='100' vspace='-15'>\",\"securitySymbol\":\"#{index_symbol}\"}]" }

  before do
    parser = Psei::Parser.new(url, headers)
    @parsed = parser.process(sample)
  end

  describe "#process" do
  
    it "returns an array" do
      @parsed.must_be_kind_of Array
    end
    
    it "returns all values" do
      @parsed.size.must_equal 3
    end
    
    it "contains the date container" do
      @parsed[0]["lastTradedPrice"].must_equal date_indicator
    end
    
    it "contains the date" do
      @parsed[0]["securityAlias"].must_equal datetime
    end
    
    it "contains the security" do
      @parsed[1]["securitySymbol"].must_equal security_symbol
    end
    
    it "contains the index" do
      @parsed[2]["securitySymbol"].must_equal index_symbol
    end
    
  end
end
