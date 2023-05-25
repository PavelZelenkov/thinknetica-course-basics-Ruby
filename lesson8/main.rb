require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_pass'
require_relative 'route'
require_relative 'station'

class Main
  attr_reader :stations, :trains, :routes, :route, :wagons
  attr_accessor :active_route, :active_train, :active_wagon, :active_station

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def start
    puts 'Добро пожаловать в интерактивную программу по ' \
         'управлению и созданию станций, поездов в и вагонов.'
    puts
    loop do
      show_menu
    end
  end

  def show_menu
    puts 'Введите 1, если вы хотите создать станцию, поезд, вагон или маршрут'
    puts 'Введите 2, если вы хотите произвести операции с созданными объектами'
    puts 'Введите 3, если вы хотите вывести текущие данные о объектах'
    puts 'Введите 0, если вы хотите закончить программу'
    menu = gets.strip

    case menu
    when '1'
      create_menu
    when '2'
      action_menu
    when '3'
      info_menu
    when '4'
      exit
    end
  end

  def create_menu
    puts 'Введите 1, если хотите создать станцию'
    puts 'Введите 2, если хотите создать поезд'
    puts 'Введите 3, если хотите создать вагон'
    puts 'Введите 4, если хотите создать маршрут'
    puts 'Введите 0, если хотите вернуться в главное меню'
    menu = gets.strip

    case menu
    when '1'
      create_station
    when '2'
      create_train
    when '3'
      create_wagon
    when '4'
      create_route
    when '0'
      show_menu
    end
  end

  def create_station
    puts 'Введите имя станции: '
    name = gets.strip
    station = Station.new(name)
    @stations << station
    puts 'Станция успешно создана'
    create_menu
  end

  def create_train
    puts 'Какой тип поезда хотите создать?'
    puts 'Введите 1, если хотите создать пассажирский поезд'
    puts 'Введите 2, если хотите создать грузовой поезд'
    puts 'Введите 0, если хотите вернуться в меню назад'
    menu = gets.strip

    case menu
    when '1'
      passenger_train
    when '2'
      cargo_train
    when '0'
      create_menu
    end
  end

  def passenger_train
    attempt = 0
    begin
      puts 'Введите название пассажирского поезда (пример ввода: "aaa-aa"):'
      name = gets.strip
      train = PassengerTrain.new(name)
    rescue RuntimeError => e
      attempt += 1
      puts "#{e.inspect} Ошибка!!! Попробуйте ещё раз"
      retry if attempt < 3
      create_menu
    end
    @trains << train
    puts 'Пассажирский поезд успешно создан'
    create_menu
  end

  def cargo_train
    attempt = 0
    begin
      puts 'Введите название грузового поезда (пример ввода: "aaa-aa"):'
      name = gets.strip
      train = CargoTrain.new(name)
    rescue RuntimeError => e
      attempt += 1
      puts "#{e.inspect} Ошибка!!! Попробуйте ещё раз"
      retry if attempt < 3
      create_menu
    end
    @trains << train
    puts 'Грузовой поезд успешно создан'
    create_menu
  end

  def create_wagon
    puts 'Какой тип вагона хотите создать?'
    puts 'Введите 1, если хотите создать пассажирский вагон'
    puts 'Введите 2, если хотите создать грузовой вагон'
    puts 'Введите 0, если хотите вернуться в меню назад'
    menu = gets.strip

    case menu
    when '1'
      passenger_wagon
    when '2'
      cargo_wagon
    when '0'
      create_menu
    end
  end

  def passenger_wagon
    puts 'Введите количество мест для пассажирского вагона'
    places = gets.strip.to_i
    wagon = PassengerWagon.new(places)
    @wagons << wagon
    puts 'Пассажирский вагон успешно создан'
    create_wagon
  end

  def cargo_wagon
    puts 'Введите общий объем грузового вагона'
    volume = gets.strip.to_i
    wagon = CargoWagons.new(volume)
    @wagons << wagon
    puts 'Грузовой вагон успешно создан'
    create_wagon
  end

  # rubocop:disable Metrics/AbcSize
  def create_route
    puts 'Выберите начальную станцию маршрута:'
    station_listing
    station = gets.strip.to_i
    begin_station = @stations[station - 1]
    puts "Вы выбрали станцию #{begin_station.name}"
    puts 'Выберите конечную станцию маршрута:'
    station_listing
    station = gets.strip.to_i
    end_station = @stations[station - 1]
    puts "Вы выбрали станцию #{end_station.name}"
    route = Route.new(begin_station, end_station)
    @routes << route
    puts 'Вы успешно создали маршрут с начальной ' \
         "станцией #{begin_station.name}; конечной станцией #{end_station.name}"
    create_menu
  end
  # rubocop:enable Metrics/AbcSize

  def action_menu
    puts 'Введите 1, если вы хотите добавить или удалить станцию в маршруте'
    puts 'Введите 2, если вы хотите назначить маршрут поезду'
    puts 'Введите 3, если вы хотите перемещать поезд по маршруту вперед и назад'
    puts 'Введите 4, если вы хотите добавить или отцепить вагон от поезда'
    puts 'Введите 5, если вы хотите занять место или объем в вагоне'
    puts 'Введите 0, если хотите вернуться в главное меню'
    menu = gets.strip

    case menu
    when '1'
      add_and_dell_stations
    when '2'
      assign_train_route
    when '3'
      to_forward_and_back_station
    when '4'
      action_with_the_wagon
    when '5'
      take_place_wagons
    when '0'
      show_menu
    end
  end

  def add_and_dell_stations
    puts 'Выберите маршрут к которому хотите добавить или удалить станцию:'
    route_selection
    puts
    loop do
      puts 'Введите 1, если хотите добавить станцию в маршруте'
      puts 'Введите 2, если хотите удалить станцию в маршруте'
      puts 'Введите 0, назад в меню'
      menu = gets.strip

      case menu
      when '1'
        adding_station_route
      when '2'
        deleting_station_route
      when '0'
        action_menu
      end
    end
  end

  def adding_station_route
    puts 'Выберите станцию, которую хотите добавить:'
    station_listing
    station = gets.strip.to_i
    st = @stations[station - 1]
    active_route.add_station(st)
    puts 'Вы успешно добавили промежуточную станцию'
    active_route_enumeration
    puts
  end

  def deleting_station_route
    puts 'Выберите станцию, которую хотите удалить:'
    active_route_enumeration
    station = gets.strip.to_i
    st = active_route.stations[station - 1]
    active_route.del_station(st)
    puts 'Вы успешно удалили станцию'
    active_route_enumeration
    puts
  end

  def assign_train_route
    puts 'Выберите поезд, которому хотите назначить маршрут:'
    train_selection
    puts 'Выберите маршрут для поезда:'
    route_selection
    puts
    active_train.assing_route(active_route)
    puts 'Маршрут успешно добавлен'
    a = active_train.route[@index_station_train = 0]
    a.add_train(active_train)
    action_menu
  end

  def to_forward_and_back_station
    puts 'Выберите поезд, который хотите перемещать по выбранному маршруту:'
    train_selection
    loop do
      puts 'Выберите 1, если хотите переместиться по маршруту вперед'
      puts 'Выберите 2, если хотите переместиться по маршруту назад'
      puts 'Выберите 0, если хотите вернуться назад в меню'
      menu = gets.strip
      case menu
      when '1'
        moving_along_the_route_forvard
      when '2'
        moving_back_along_the_route
      when '0'
        action_menu
      end
    end
  end

  def action_with_the_wagon
    puts 'Выберите поезд к которому хотите добавить вагон:'
    train_selection
    puts "Количество прицепленных вагонов: #{active_train.wagons.length}"
    loop do
      puts 'Введите 1, если хотите добавить вагон'
      puts 'Введите 2, если хотите отцепить вагон'
      puts 'Введите 0, если хотите выйти в главное меню'
      menu = gets.strip

      case menu
      when '1'
        adding_a_wagon
      when '2'
        wagon_uncoupling
      when '0'
        action_menu
      end
    end
  end

  def adding_a_wagon
    puts 'Выберите вагон который хотите добавить'
    wagon_selection
    if active_wagon.type == active_train.type
      active_train.add_wagons(active_wagon)
      puts "Поезд: #{active_train.number}. " \
           "Количество вагонов: #{active_train.wagons.length}"
    else
      puts 'Тип вагона не совпадает с типом поезда, выберите другой вагон'
    end
  end

  def wagon_uncoupling
    active_train.unhook_wagons
    puts 'Вагон отцеплен'
    puts "Поезд: #{active_train.number}. " \
         "Количество вагонов: #{active_train.wagons.length}"
  end

  def take_place_wagons
    create_wagon if @wagons.empty?
    puts 'Выберите вагон с которым хотите совершить действие'
    wagon_selection
    loop do
      take_of_release
    end
  end

  def take_of_release
    print "Занято: #{active_wagon.used_place}, "
    puts "Свободно: #{active_wagon.free_place}"
    puts 'Введите 1, если хотите занять объем или место'
    puts 'Введите 0, если хотите выйти в меню выбора действий с объектами'
    menu = gets.strip

    case menu
    when '1'
      if active_wagon.type == 'cargo'
        volume_setting
      else
        active_wagon.take_place
      end
    when '0'
      action_menu
    end
  end

  def info_menu
    puts 'Введите 1, если хотите просматривать список станций'
    puts 'Введите 2, если хотите просматривать список поездов на станции'
    puts 'Введите 3, ' \
         'если хотите просматривать список вагонов у выбранного поезда'
    puts 'Введите 0, если хотите вернуться в главное меню'
    menu = gets.strip

    case menu
    when '1'
      station_listing
    when '2'
      list_of_trains_at_the_station
    when '3'
      list_of_cars_at_the_train
    when '0'
      show_menu
    end
  end

  def station_list
    station_listing
    info_menu
  end

  def list_of_trains_at_the_station
    puts 'Выберите станцию на которой хотите посмотреть список поездов'
    station_listing
    station = gets.strip.to_i
    self.active_station = @stations[station - 1]
    puts "Выбрана станция #{active_station.name}."
    puts 'Список поездов:'
    active_station.train_each
    info_menu
  end

  def list_of_cars_at_the_train
    puts 'Выберите поезд у которого хотите посмотреть список вагонов'
    train_enumeration
    train = gets.strip.to_i
    self.active_train = @trains[train - 1]
    puts "Вы успешно выбрали поезд #{active_train.number}"
    active_train.wagon_each
    info_menu
  end

  protected

  def station_listing
    @stations.each_index do |index|
      print "№ #{index + 1}. "
      st = stations[index]
      # rubocop:disable Lint/RedundantStringCoercion
      puts st.name.to_s
      # rubocop:enable Lint/RedundantStringCoercion
    end
  end

  def wagon_enumeration
    @wagons.each_index do |index|
      print "#{index + 1}) "
      a = wagons[index]
      print "Номер вагона: #{a.number}. Тип вагона: #{a.type}"
      puts
    end
  end

  def train_enumeration
    @trains.each_index do |index|
      print "№ #{index + 1}. "
      st = @trains[index]
      print "#{st.number}. тип поезда: #{st.type}"
      puts
    end
  end

  def route_enumeration
    @routes.each_index do |index|
      print "№ #{index + 1}. "
      rout = @routes[index]
      rout_in = rout.stations
      rout_in.each do |i|
        print "#{i.name} "
      end
      puts
    end
  end

  def active_route_enumeration
    a = active_route.stations
    a.each do |index|
      print "#{index.name} "
    end
  end

  def train_selection
    train_enumeration
    train = gets.strip.to_i
    self.active_train = @trains[train - 1]
    puts "Вы успешно выбрали поезд #{active_train.number}"
  end

  def route_selection
    route_enumeration
    rout = gets.strip.to_i
    self.active_route = routes[rout - 1]
    print 'Вы успешно выбрали маршрут: '
    active_route_enumeration
  end

  def wagon_selection
    wagon_enumeration
    selected_wagon = gets.strip.to_i
    self.active_wagon = @wagons[selected_wagon - 1]
    puts "Вы выбрали: Номер вагона #{active_wagon.number}. " \
         "Тип вагона #{active_wagon.type}"
  end

  def volume_setting
    puts 'Введите объем'
    volume = gets.strip.to_i
    active_wagon.take_place(volume)
  end

  def moving_along_the_route_forvard
    active_train.to_forward_station(active_route)
    return if active_train.route[@index_station_train + 1].nil?

    index_route_forvard
  end

  def index_route_forvard
    a = active_train.route[@index_station_train]
    a.send_train(active_train)
    a = active_train.route[@index_station_train += 1]
    a.add_train(active_train)
  end

  def moving_back_along_the_route
    active_train.to_back_station(active_route)
    if active_train.route[@index_station_train - 1] == active_train.route[-1]
      return
    end

    index_route_back
  end

  def index_route_back
    a = active_train.route[@index_station_train]
    a.send_train(active_train)
    a = active_train.route[@index_station_train -= 1]
    a.add_train(active_train)
  end
end

main = Main.new
main.start
