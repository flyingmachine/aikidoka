module Aikidoka
  # Keys should be old names of classes/modules to rename,
  # Values should be new names
  def self.rename(pairs = {})
    create_modules(*pairs.values)
    #protect_existing_constants
    yield
    copy_constants(pairs)
    remove_constants(*pairs.keys)
  end
  
  def self.create_modules(*module_names)
    module_names.uniq.each do |name|
      pieces = name.split("::")
      pieces.pop
      parent_constant = Object
      pieces.each do |piece|
        if parent_constant.const_defined?(piece)
          parent_constant = parent_constant.const_get(piece)
        else
          new_module = Module.new
          parent_constant.const_set(piece, new_module)
          parent_constant = new_module
        end
      end
    end
  end
  
  def self.copy_constants(pairs)
    pairs.each do |old_name, new_name|
      eval("#{new_name}= #{old_name}")
    end
  end
  
  def self.remove_constants(*modules_names)
    modules_names.each do |name|
      Object.send(:remove_const, name)
    end
  end
end