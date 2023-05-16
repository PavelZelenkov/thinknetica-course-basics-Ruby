class Wagon
  include Manufacturer

  attr_reader :type, :number

  @@number_wagon = 0

  def initialize(number)
    @@number_wagon += 1
    @number = @@number_wagon
    @type = type
  end
  
end
