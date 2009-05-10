require 'aikidoka'

describe Aikidoka do
  it "should create modules for all but most-nested constant name" do
    Object.const_defined?(:Weapons).should be_false
    Aikidoka.create_modules("Weapons::Bokken")
    Object.const_defined?(:Weapons).should be_true
    Weapons.const_defined?(:Bokken).should be_false
  end
  
  it "should remove constants" do
    module Weapons; end
    Object.const_defined?(:Weapons).should be_true
    Aikidoka.remove_constants(:Weapons)
    Object.const_defined?(:Weapons).should be_false
  end
  
  it "should rename a top-level constant" do
    Aikidoka.rename("Weapons" => "JapaneseArts::Weapons") do 
      module Weapons
        def strike
        end
      end
    end
    Object.const_defined?(:Weapons).should be_false
    Object.const_defined?(:JapaneseArts).should be_true
    JapaneseArts.const_defined?(:Weapons).should be_true
    JapaneseArts::Weapons.method_defined?(:strike).should be_true
  end
end