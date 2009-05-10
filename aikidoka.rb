class Mash
end

module Namespace
end

Namespace.const_set("Mash", Mash)

puts Namespace::Mash
Object.send(:remove_const, :Mash)
puts Namespace::Mash

module Aikidoka
  # Keys should be new names,
  # Values should be names of classes/modules to rename
  def self.rename(pairs => {})
    create_modules(pairs.keys)
    
  end
  
  def create_modules(module_names)
    module_names.uniq.each do |name|
      pieces = name.split("::")

      
    end
  end
end