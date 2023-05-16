class PassengerWagon < Wagon
  attr_reader :occupied_place, :free_place, :places
  
  def initialize(places)
    @type = 'pass'
    @places = places
    @occupied_place = 0
    super
  end

  def take_the_place_of # занять место - по одному
    @occupied_place += 1 if @occupied_place < @places
  end

  def occupied_place # выводит занятые места
    @occupied_place
  end

  def free_place # свободные места
    @free_place = @places - @occupied_place
  end
end
