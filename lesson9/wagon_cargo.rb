class CargoWagons < Wagon
  def initialize(total_place, number = 'Unknown')
    @type = 'cargo'
    super
  end

  def take_place(volume)
    @used_place = volume if volume <= @total_place
  end
end
