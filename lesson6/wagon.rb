class Wagon
  include Manufacturer

  attr_reader :type

  def initialize
    @type = type
  end
  
end
