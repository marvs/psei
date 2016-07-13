require 'test_helper'

describe Psei do
  describe "gem version" do
    it "must not be blank" do
      Psei::VERSION.wont_be_nil
    end
  end
end
