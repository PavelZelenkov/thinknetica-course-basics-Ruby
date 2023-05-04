class Train # Поезд
  include Manufacturer
  include InstanceCounter

  attr_accessor :wagons, :speed
  attr_reader :number, :type, :route

  NUMBER = /^\w{3}(.\w{2})?$/

  class << self
    def all_train
      @@all_train ||= []
    end
    
    def find(number)
      @@all_train.select {|index| index.number == "#{number}"}
    end
  end

  def initialize(number, speed = 0)
    @speed = speed
    @number = number
    validate!
    @type = type
    @wagons = []
    self.class.all_train << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def go(km) # устанавливаем скорость поезда
    self.speed = km
  end

  def stop # останавливаем поезд
    self.speed = 0
  end

  def prev_station # возвращает предыдущую станцию
    if @route[@current_station_index - 1] == @route[-1]
    else
      @route[@current_station_index - 1]
    end
  end

  def current_station # возвращаем текущую станцию
    @route[@current_station_index]
  end

  def next_station # возвращаем следующую станцию
    if @route[@current_station_index + 1] == nil
    else
      @route[@current_station_index + 1]
    end
  end

  def assing_route(route) # добавляем маршрут из класса Route и помещаем поезд на первую станцию маршрута
    @route = route.stations
    @current_station_index = 0
    a = route.stations[@current_station_index]
    puts "Начало маршрута со станции #{a.name}"
  end
  
  def to_forward_station(route) # перемещаем поезд вперед на одну станцию
    @current_station_index += 1 if next_station
    puts "Вперед на одну станцию"
  end

  def to_back_station(route) # перемещаем поезд на одну станцию назад
    @current_station_index -= 1 if prev_station
    puts "Назад на одну станцию"
  end

  def add_wagons(wagon) # добавляем вагон при скорости поезда 0
    if @speed == 0 && @type == wagon.type
      @wagons << wagon
    end
  end

  def unhook_wagons # отцепляем вагон при скорости поезда 0
    if @speed == 0
      @wagons.delete_at(-1)
    end
  end

  protected

  def validate!
    errors = []
    errors << "Название станции не должно быть пустым" if number == ''
    errors << "Message" if number !~ NUMBER
    raise errors.join('.') unless errors.empty?
  end

end
