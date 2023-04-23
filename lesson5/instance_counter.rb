module InstanceCounter # метод подсчета и возвращения экземпляров

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    
    $instances = 0

    def instances
      $instances
    end
  end

  module InstanceMethods

    private

    def register_instance
      $instances += 1
    end      
  end
end
