class PassengerTrain < Train
  
  attr_accessor :number
  
  def initialize(number, type = 'pass', speed = 0)
    @speed = speed
    @number = number
    @type = type
    @wagons = []
    @routes = routes
  end

end
