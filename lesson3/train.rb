class Train # Поезд
  attr_accessor :number_wagons, :speed
  attr_reader :arbitrary_str, :type, :routes

  def initialize(arbitrary_str, type, number_wagons, speed = 0)
    @speed = speed
    @arbitrary_str = arbitrary_str
    @type = type
    @number_wagons = number_wagons
    @routes = routes
  end

  def go(km) # устанавливаем скорость поезда
    self.speed = km
  end

  def stop # останавливаем поезд
    self.speed = 0
  end

  def add_wagons # добавляем вагон при скорости поезда 0
    if @speed == 0
      @number_wagons += 1
    end
  end

  def send_wagons # отцепляем вагон при скорости поезда 0
    if @speed == 0
      @number_wagons -= 1
    end
  end

  def new_routes(route) # добавляем маршрут из класса Route и помещаем поезд на первую станцию маршрута
    puts "Список станций:"
    @routes = route.route.each { |i| puts i }
    self.routes[@index_station = 0]
    puts "Начало маршрута со станции: #{route.route[@index_station]}"
  end
  
  def to_forward_station # перемещаем поезд вперед на одну станцию
    if @routes[@index_station + 1] == nil
    else
      @routes[@index_station += 1]
    end
  end

  def to_back_station # перемещаем поезд на одну станцию назад
    if @routes[@index_station - 1] == @routes[-1]
    else
      @routes[@index_station -= 1]
    end
  end

  def prev_station # возвращает предыдущую станцию
    if @routes[@index_station - 1] == @routes[-1]
    else
      @routes[@index_station - 1]
    end
  end

  def current_station # возвращаем текущую станцию
    @routes[@index_station]
  end

  def next_station # возвращаем следующую станцию
    if @routes[@index_station + 1] == nil
    else
      @routes[@index_station + 1]
    end
  end
end
