require 'aikidoka'

describe Aikidoka do
  it "should create modules" do
    Object.const_defined?(:Weapons).should be_false
    Aikidoka.create_modules("Weapons")
    Object.const_defined?(:Weapons).should be_true
  end
end