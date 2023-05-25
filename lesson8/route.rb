class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def del_station(station)
    stations.delete(station)
  end

  def all_stations
    # rubocop:disable Lint/RedundantStringCoercion
    stations.each { |i| puts i.to_s }
    # rubocop:enable Lint/RedundantStringCoercion
    stations.size
  end

  protected

  def validate!
    errors = []
    if stations[0] == '' || stations[1] == ''
      errors << 'Пустые названия станций'
    end
    raise errors.join('.') unless errors.empty?
  end
end
