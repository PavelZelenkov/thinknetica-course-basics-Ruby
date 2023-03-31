class Route # Маршрут
  attr_reader :route

  def initialize(starting_st, end_st) # начальная и конечная станция
    @route = [starting_st, end_st]
  end

  def add_station(station) # добавление промежуточных станций
    @route.insert(-2, station)
  end

  def del_station(station) # удаление промежуточных станций
    @route.delete(station)
  end

  def all_stations # выводит список всех станций по порядку от начальной до конечной
    @route.each { |i| puts "#{i}" }
    @route.size
  end
end
