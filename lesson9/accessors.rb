module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_accessor :history

    def attr_accessor_with_history(*methods)
      methods.each do |method|
        define_method(method) do
          instance_variable_get("@#{method}")
        end
        define_method("#{method}=") do |value|
          @history ||= {}
          @value_history ||= []
          instance_variable_set("@#{method}", value)
          @value_history << instance_variable_get("@#{method}")
          @history[method] = @value_history
        end
        define_method("#{method}_history") do
          @history ||= {}
          @history[method]
        end
      end
    end

    def strong_attr_accessor(name, value_type)
      define_method(name) do
        instance_variable_get("@#{name}")
      end
      define_method("#{name}=") do |value|
        value.class == type.class ? instance_variable_set("@#{name}", value) : raise('Incorrect value type')
      end
    end
  end
end
