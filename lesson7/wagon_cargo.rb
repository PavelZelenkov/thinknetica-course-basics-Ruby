class CargoWagons < Wagon
  attr_reader :overall_volume, :occupied_volume, :free_volume

  def initialize(overall_volume)
    @type = 'cargo'
    @overall_volume = overall_volume
    @occupied_volume = 0
    super
  end
  
  def take_up_volume(volume) # занять объем
    @occupied_volume = volume if volume <= @overall_volume
  end

  def occupied_volume # возвращает занятый объем
    @occupied_volume
  end

  def free_volume # возвращает свободный объем
    @free_volume = @overall_volume - @occupied_volume
  end
end
