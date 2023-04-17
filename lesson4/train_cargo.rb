class CargoTrain < Train

  attr_accessor :number
  
  def initialize(number, type = 'cargo', speed = 0)
    @speed = speed
    @number = number
    @type = type
    @wagons = []
    @routes = routes
  end

end
