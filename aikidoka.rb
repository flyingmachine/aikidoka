module Aikidoka
  # Keys should be old names of classes/modules to rename,
  # Values should be new names
  def self.rename(pairs = {})
    hide_existing_constants(*pairs.keys)
    yield
    create_modules(*pairs.values)
    copy_constants(pairs)
    remove_constants(*pairs.keys)
    unhide_constants(*pairs.keys) 
  end
  
  def self.create_modules(*constant_names)
    constant_names.uniq.each do |name|
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
      parent_constant = Object
      namespace_pieces = new_name.split("::")
      new_constant_name = namespace_pieces.pop
      
      namespace_pieces.each do |piece|
        parent_constant = parent_constant.const_get(piece)
      end
      parent_constant.const_set(new_constant_name, Object.class_eval(old_name))
    end
  end
  
  def self.remove_constants(*constant_names)
    constant_names.each do |name|
      Object.send(:remove_const, name)
    end
  end
  
  def self.hide_existing_constants(*constant_names)
    constant_names.each do |name|
      if(Object.const_defined? name)
        Object.const_set("Aikidoka#{name}", Object.const_get(name))
        Object.send(:remove_const, name)
      end
    end
  end
  
  def self.unhide_constants(*constant_names)
    constant_names.each do |name|
      hidden_name = "Aikidoka#{name}"
      if(Object.const_defined? hidden_name)
        Object.const_set(name, Object.const_get(hidden_name))
        Object.send(:remove_const, hidden_name)
      end
    end  end
end