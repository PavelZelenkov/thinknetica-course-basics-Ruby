class Route
  include InstanceCounter
  include Accessors

  attr_reader :stations

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    register_instance
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
end
