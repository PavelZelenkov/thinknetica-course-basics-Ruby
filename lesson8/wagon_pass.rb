class PassengerWagon < Wagon
  def initialize(total_place, number = 'Unknown')
    @type = 'pass'
    super
  end

  def take_place
    @used_place += 1 if @used_place < @total_place
  end
end
