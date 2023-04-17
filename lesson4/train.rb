class Train # Поезд
  attr_accessor :wagons, :speed
  attr_reader :number, :type, :routes

  def initialize(number, speed = 0)
    @speed = speed
    @number = number
    @type = type
    @wagons = []
    @routes = routes
  end

  def go(km) # устанавливаем скорость поезда
    self.speed = km
  end

  def stop # останавливаем поезд
    self.speed = 0
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

  def new_routes(route) # добавляем маршрут из класса Route и помещаем поезд на первую станцию маршрута
    @routes = route.route
    self.routes[@index_station = 0]
    a = route.route[@index_station]
    puts "Начало маршрута со станции: #{a.name}"
  end
  
  def to_forward_station(route) # перемещаем поезд вперед на одну станцию
    if @routes[@index_station + 1] == nil
      puts "Дальше маршрута нет"
    else
      @routes[@index_station += 1]
      a = route.route[@index_station]
      puts "Поезд переместился на станцию: #{a.name}"
    end
  end

  def to_back_station(route) # перемещаем поезд на одну станцию назад
    if @routes[@index_station - 1] == @routes[-1]
      puts "Дальше маршрута нет"
    else
      @routes[@index_station -= 1]
      a = route.route[@index_station]
      puts "Поезд переместился на станцию: #{a.name}"
    end
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

end
