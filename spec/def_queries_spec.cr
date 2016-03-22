require "./spec_helper"
require "./examples/*"

describe Cryesql::Parser do

  it "should define select queries" do
    Selects.new.foo.should eq("foo")
  end

end
