class PassengerWagon < Wagon
  def initialize(number = 0, total_place)
    @type = 'pass'
    super
  end

  def take_place # занять место - по одному
    @used_place += 1 if @used_place < @total_place
  end
end
