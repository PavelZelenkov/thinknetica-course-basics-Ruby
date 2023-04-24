module InstanceCounter # метод подсчета и возвращения экземпляров

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def instances
      @@instances
    end

    def add_instances
      @@instances += 1
    end

    @@instances ||= 0

  end

  module InstanceMethods

    private

    def register_instance
      self.class.add_instances
    end
  end
end
