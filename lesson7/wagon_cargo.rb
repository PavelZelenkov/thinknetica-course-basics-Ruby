class CargoWagons < Wagon
  def initialize(number = 0, total_place)
    @type = 'cargo'
    super
  end
  
  def take_place(volume) # занять объем
    @used_place = volume if volume <= @total_place
  end
end
