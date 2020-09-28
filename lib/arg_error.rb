module ArgError

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def arg_class_check(arg, arg_name, expected_class)
      raise ArgumentError.new("#{arg_name} must be an instance of #{expected_class}") if !arg.instance_of? expected_class
    end
  end

  def arg_class_check(arg, arg_name, expected_class)
    raise ArgumentError.new("#{arg_name} must be an instance of #{expected_class}") if !arg.instance_of? expected_class
  end

end
