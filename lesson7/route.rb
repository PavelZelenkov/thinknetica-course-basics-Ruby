class Route # Маршрут
  include InstanceCounter

  attr_reader :stations

  def initialize(begin_station, end_station) # начальная и конечная станция
    @stations = [begin_station, end_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_station(station) # добавление промежуточных станций   
    stations.insert(-2, station)
  end

  def del_station(station) # удаление промежуточных станций
    stations.delete(station)
  end

  def all_stations # выводит список всех станций по порядку от начальной до конечной
    stations.each { |i| puts "#{i}" }
    stations.size
  end

  protected

  def validate!
    errors = []
    errors << "Пустые названия станций" if stations[0] == '' || stations[1] == '' # начальные и конечные станции не должны быть пустыми
    raise errors.join('.') unless errors.empty?
  end
end
