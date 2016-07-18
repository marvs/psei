require "date"
require "psei/version"
require "psei/parser"
require "psei/formatter"
require "psei/security"
require "psei/index"
require "psei/date"

module Psei
  SOURCE_URL = "http://pse.com.ph/stockMarket/home.html?method=getSecuritiesAndIndicesForPublic&ajax=true"
  HEADING_ALIAS = "Stock Update As of"
  INDEX_ALIASES = [ "PSEi", "All Shares", "Financials", "Industrial", "Holding Firms", "Property", 
                    "Services", "Mining and Oil"].freeze
end
