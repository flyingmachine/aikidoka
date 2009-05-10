require 'aikidoka'

describe Aikidoka do
  it "should create modules/classes for all but most-nested constant name" do
    Object.const_defined?(:Weapons).should be_false
    Aikidoka.create_modules("Weapons::Bokken")
    Object.const_defined?(:Weapons).should be_true
    Weapons.const_defined?(:Bokken).should be_false
    
    remove_constant_hierarchy("Weapons")
  end
  
  it "should create modules/classes for all but most-nested constant name when constants with those names exist" do
    module Aikido; class Weapons; class Bokken; end end end
    Aikidoka.create_modules("Aikido::Weapons::Bokken")
    
    remove_constant_hierarchy("Aikido::Weapons")
  end
  
  it "should remove constants" do
    module Weapons; end
    Object.const_defined?(:Weapons).should be_true
    Aikidoka.remove_constants(:Weapons)
    Object.const_defined?(:Weapons).should be_false
  end
  
  it "should rename a top-level constant" do
    Aikidoka.rename("Weapons" => "Aikido::Weapons") do 
      module Weapons
        def strike
        end
      end
    end
    Object.const_defined?(:Weapons).should be_false
    Object.const_defined?(:Aikido).should be_true
    Aikido.const_defined?(:Weapons).should be_true
    Aikido::Weapons.method_defined?(:strike).should be_true
    
    remove_constant_hierarchy("Aikido::Weapons")
  end
end

# each name is i.e. Aikido::Weapons::Bokken
def remove_constant_hierarchy(*names)
  names.each do |name|
    pieces = name.split("::")
    pieces.size.downto(1).each do |size|
      to_remove = pieces.pop
      const_name = pieces.join("::")
      parent = Object.class_eval(const_name) || Object
      parent.send(:remove_const, to_remove)
    end
  end
end