module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, validation, *params)
      @validations ||= []
      @validations << { variable: name, type: validation, options: params.first }
    end
  end

  module InstanceMethods
    attr_reader :variable

    def validate!
      self.class.validations.each do |validation|
        value = get_var(validation[:variable])
        send("validate_#{validation[:type]}", validation[:variable], value, validation[:options])
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError => e
      false
    end

    def get_var(name)
      instance_variable_get("@#{name}")
    end

    protected

    def validate_presence(variable, value, *)
      raise ArgumentError, "#{self}: in '#{variable}' - value format error" if value.to_s.empty?
    end

    def validate_format(variable, value, format)
      raise ArgumentError, "#{self}: in '#{variable}' - value format error" if value !~ format
    end

    def validate_type(variable, value, value_type)
      raise ArgumentError, "#{self}: in '#{variable}' - value format error" if value.class != value_type
    end
  end
end
