class Train
  include Validation
  include Manufacturer
  include InstanceCounter
  include Accessors

  attr_accessor :wagons, :speed
  attr_reader :number, :type, :route

  class << self
    def all_train
      @@all_train ||= []
    end

    def find(number)
      @@all_train.select { |index| index.number == number.to_s }
    end
  end

  def initialize(number, speed = 0)
    @speed = speed
    @number = number
    @type = type
    @wagons = []
    self.class.all_train << self
    register_instance
    validate!
  end

  def wagon_block(wagons, &block)
    block.call(wagons)
  end

  def wagon_each
    wagon_block(@wagons) do |x|
      x.each do |i|
        puts "Номер вагона № #{i.number} || Занято: #{i.used_place}, " \
             "Свободно: #{i.free_place}"
      end
    end
  end

  def go(kilometer)
    self.speed = kilometer
  end

  def stop
    self.speed = 0
  end

  def prev_station
    return if @route[@current_station_index - 1] == @route[-1]

    @route[@current_station_index - 1]
  end

  def current_station
    @route[@current_station_index]
  end

  def next_station
    return if @route[@current_station_index + 1].nil?

    @route[@current_station_index + 1]
  end

  def assing_route(route)
    @route = route.stations
    @current_station_index = 0
    a = route.stations[@current_station_index]
    puts "Начало маршрута со станции #{a.name}"
  end

  def to_forward_station(_route)
    @current_station_index += 1 if next_station
    puts 'Вперед на одну станцию'
  end

  def to_back_station(_route)
    @current_station_index -= 1 if prev_station
    puts 'Назад на одну станцию'
  end

  def add_wagons(wagon)
    return unless @speed.zero? && @type == wagon.type

    @wagons << wagon
  end

  def unhook_wagons
    return unless @speed.zero?

    @wagons.delete_at(-1)
  end
end
