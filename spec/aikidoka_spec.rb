require 'aikidoka'

describe Aikidoka do
  it "should create modules for all but most-nested constant name" do
    Object.const_defined?(:Weapons).should be_false
    Aikidoka.create_modules("Weapons::Bokken")
    Object.const_defined?(:Weapons).should be_true
    Weapons.const_defined?(:Bokken).should be_false
  end
  
  it "should remove constnts" do
    module Weapons; end
    Object.const_defined?(:Weapons).should be_true
    Aikidoka.remove_constants(:Weapons)
    Object.const_defined?(:Weapons).should be_false
  end
end