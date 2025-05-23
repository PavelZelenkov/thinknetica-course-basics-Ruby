class Wagon
  include Manufacturer

  attr_reader :type, :number, :total_place, :used_place

  @@number_wagon = 0

  def initialize(total_place, _number)
    @type = type
    @@number_wagon += 1
    @number = @@number_wagon
    @total_place = total_place
    @used_place = 0
  end

  def free_place
    total_place - used_place
  end

  def take_place
    raise 'not implemented'
  end
end
