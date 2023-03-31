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
    self.routes[@r = 0]
    puts "Начало маршрута со станции: #{route.route[@r]}"
  end
  
  def forward_st # перемещаем поезд вперед на одну станцию
    if @routes[@r + 1] == nil
      puts "Конечная, дальше поезд не идёт!"
    else
      @routes[@r += 1]
    end
  end

  def back_st # перемещаем поезд на одну станцию назад
    if @routes[@r - 1] == @routes[-1]
      "Cтанций нет!"
    else
      @routes[@r -= 1]
    end
  end

  def return_st # возвращаем список станций - предыдущая, текущая, конечная.
    if @routes[@r - 1] == @routes[-1]
      puts "Предыдущих станций нет!"
    else
      puts "Предыдущая станция: #{@routes[@r - 1]}"
    end
      puts "Текущая станция: #{@routes[@r]}"
    if @routes[@r + 1] == nil
      puts "Конечная, дальше поезд не идёт!"
    else
      puts "Следующая станция: #{@routes[@r + 1]}"
    end
  end
end
