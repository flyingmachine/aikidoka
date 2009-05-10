require 'aikidoka'

describe Aikidoka do
  it "should create un-nested module" do
    Object.const_defined?(:Weapons).should be_false
    Aikidoka.create_modules("Weapons")
    Object.const_defined?(:Weapons).should be_true
  end
  
  it "should create nested module" do
    Aikidoka.create_modules("Weapons::Bokken")
    Weapons.const_defined?("Bokken").should be_true
  end
end