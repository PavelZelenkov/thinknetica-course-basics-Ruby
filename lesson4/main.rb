require_relative 'train.rb'
require_relative 'train_pass.rb'
require_relative 'train_cargo'
require_relative 'wagon.rb'
require_relative 'wagon_cargo'
require_relative 'wagon_pass'
require_relative 'route.rb'
require_relative 'station.rb'

class Main

  attr_reader :stations, :trains, :routes, :route, :wagons, :wagons
  attr_accessor :active_route, :active_train, :active_wagon, :active_station

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def start
    puts "Добро пожаловать в интерактивную программу по управлению и созданию станций, поездов в и вагонов."
    puts
    loop do
      show_menu
    end
  end

  def show_menu 
    puts "Введите 1, если вы хотите создать станцию, поезд, вагон или маршрут"
    puts "Введите 2, если вы хотите произвести операции с созданными объектами"
    puts "Введите 3, если вы хотите вывести текущие данные о объектах"
    puts "Введите 0, если вы хотите закончить программу"
    menu = gets.strip
    create_menu if menu == "1"
    action_menu if menu == "2"
    info_menu if menu == "3"
    exit if menu == "0"
  end

  def create_menu
    puts "Введите 1, если хотите создать станцию"
    puts "Введите 2, если хотите создать поезд"
    puts "Введите 3, если хотите создать вагон"
    puts "Введите 4, если хотите создать маршрут"
    puts "Введите 0, если хотите вернуться в главное меню"
    menu = gets.strip
    create_station if menu == "1"
    create_train if menu == "2"
    create_wagon if menu == "3"
    create_route if menu == "4"
    show_menu if menu == "0"
  end

  def create_station # создание станции
    puts "Введите имя станции: "
    name = gets.strip
    station = Station.new(name)
    @stations << station
    puts "Станция успешно создана"
    create_menu
  end

  def create_train # создание поезда
    puts "Какой тип поезда хотите создать?"
    puts "Введите 1, если хотите создать пассажирский поезд"
    puts "Введите 2, если хотите создать грузовой поезд"
    puts "Введите 0, если хотите вернуться в меню назад"
    menu = gets.strip
    passenger_train if menu == "1"
    cargo_train if menu == "2"
    create_menu if menu == "0"
  end

  def passenger_train # создание пассажирского поезда
    puts "Введите название пассажирского поезда:"
    name = gets.strip
    train = PassengerTrain.new(name)
    @trains << train
    puts "Пассажирский поезд успешно создан"
    create_menu
  end

  def cargo_train # создание грузового поезда
    puts "Введите название грузового поезда:"
    name = gets.strip
    train = CargoTrain.new(name)
    @trains << train
    puts "Грузовой поезд успешно создан"
    create_menu
  end

  def create_wagon
    puts "Какой тип вагона хотите создать?"
    puts "Введите 1, если хотите создать пассажирский вагон"
    puts "Введите 2, если хотите создать грузовой вагон"
    puts "Введите 0, если хотите вернуться в меню назад"
    menu = gets.strip
    passenger_wagon if menu == "1"
    cargo_wagon if menu == "2"
    create_menu if menu == "0"
  end

  def passenger_wagon # создание пассажирского вагона
    wagon = PassengerWagon.new
    @wagons << wagon
    puts "Пассажирский вагон успешно создан"
    create_wagon
  end

  def cargo_wagon # создание грузового вагона
    wagon = CargoWagons.new
    @wagons << wagon
    puts "Грузовой вагон успешно создан"
    create_wagon
  end

  def create_route # создание маршрута
    puts "Выберите начальную станцию маршрута:"
    station_listing
    station = gets.strip.to_i
    begin_station = @stations[station - 1]
    puts "Вы выбрали станцию #{begin_station.name}"
    puts "Выберите конечную станцию маршрута:"
    station_listing
    station = gets.strip.to_i
    end_station = @stations[station - 1]
    puts "Вы выбрали станцию #{end_station.name}"
    route = Route.new(begin_station, end_station)
    @routes << route
    puts "Вы успешно создали маршрут с начальной станцией #{begin_station.name} и конечной станцией #{end_station.name}"
    create_menu
  end

  def action_menu
    puts "Введите 1, если вы хотите добавить или удалить станцию в маршруте"
    puts "Введите 2, если вы хотите назначить маршрут поезду"
    puts "Введите 3, если вы хотите перемещать поезд по маршруту вперед и назад"
    puts "Введите 4, если вы хотите добавить или отцепить вагон от поезда"
    puts "Введите 0, если хотите вернуться в главное меню"
    menu = gets.strip
    add_and_dell_stations if menu == "1"
    assign_train_route if menu == "2"
    to_forward_and_back_station if menu == "3"
    action_with_the_wagon if menu == "4"
    show_menu if menu == "0"
  end

  def add_and_dell_stations # добавление и удаление промежуточных станций
    puts "Выберите маршрут к которому хотите добавить или удалить станцию:"
    route_enumeration
    rout = gets.strip.to_i
    self.active_route = routes[rout - 1]
    print "Вы успешно выбрали маршрут: "
    active_route_enumeration
    puts
    loop do
      puts "Введите 1, если хотите добавить станцию в маршруте"
      puts "Введите 2, если хотите удалить станцию в маршруте"
      puts "Введите 0, назад в меню"
      menu = gets.strip
      adding_station_route if menu == "1"
      deleting_station_route if menu == "2"
      action_menu if menu == "0"
    end
  end

  def adding_station_route # добавление станции в маршрут
    puts "Выберите станцию, которую хотите добавить:"
    station_listing
    station = gets.strip.to_i
    st = @stations[station - 1]
    self.active_route.add_station(st)
    puts "Вы успешно добавили промежуточную станцию"
    active_route_enumeration
    puts
  end

  def deleting_station_route # удаление станции из маршрута
    puts "Выберите станцию, которую хотите удалить:"
    active_route_enumeration
    station = gets.strip.to_i
    st = active_route.route[station - 1]
    self.active_route.del_station(st)
    puts "Вы успешно удалили станцию"
    active_route_enumeration
    puts
  end

  def active_route_enumeration # маршрут активный для изменения
    a = active_route.route
    a.each do |index|
      print "#{index.name} "
    end
  end

  def route_enumeration # общий список маршрутов для выбора
    @routes.each_index do |index|
      print "№ #{index + 1}. "
      rout = @routes[index]
      rout_in = rout.route
      rout_in.each do |i|
        print "#{i.name} "
      end
      puts
    end
  end

  def assign_train_route # назначение маршрута поезду
    puts "Выберите поезд, которому хотите назначить маршрут:"
    train_enumeration
    train = gets.strip.to_i
    self.active_train = @trains[train - 1]
    puts "Вы успешно выбрали поезд #{active_train.number}"
    puts "Выберите маршрут для поезда:"
    route_enumeration
    rout = gets.strip.to_i
    self.active_route = routes[rout - 1]
    print "Выбран маршрут: "
    active_route_enumeration
    puts
    self.active_train.new_routes(active_route)
    puts "Маршрут успешно добавлен"
    a = active_train.routes[@index_station_train = 0]
    a.add_train(active_train)
    action_menu
  end

  def to_forward_and_back_station # перемещение поезда по станциям маршрута с добавлением поезда на станции и его отправки
    puts "Выберите поезд, который хотите перемещать по выбранному маршруту:"
    train_enumeration
    train = gets.strip.to_i
    self.active_train = @trains[train - 1]
    puts "Вы успешно выбрали поезд #{active_train.number}"
    loop do
      puts "Выберите 1, если хотите переместиться по маршруту вперед"
      puts "Выберите 2, если хотите переместиться по маршруту назад"
      puts "Выберите 0, если хотите вернуться назад в меню"
      menu = gets.strip
      if menu == "1"
        self.active_train.to_forward_station(active_route)
        if active_train.routes[@index_station_train + 1] == nil
        else
          a = active_train.routes[@index_station_train]
          a.send_train(active_train)
          a = active_train.routes[@index_station_train += 1]
          a.add_train(active_train)
        end
      elsif menu == "2"
        self.active_train.to_back_station(active_route)
        if active_train.routes[@index_station_train - 1] == active_train.routes[-1]
        else
          a = active_train.routes[@index_station_train]
          a.send_train(active_train)
          a = active_train.routes[@index_station_train -= 1]
          a.add_train(active_train)
        end
      elsif menu == "0"
        action_menu
      end
    end
  end

  def action_with_the_wagon
    puts "Выберите поезд к которому хотите добавить вагон:"
    train_enumeration
    train = gets.strip.to_i
    self.active_train = @trains[train - 1]
    puts "Вы успешно выбрали поезд #{active_train.number}"
    puts "Количество прицепленных вагонов: #{active_train.wagons.length}"
    loop do
      puts "Введите 1, если хотите добавить вагон"
      puts "Введите 2, если хотите отцепить вагон"
      puts "Введите 0, если хотите выйти в главное меню"
      menu = gets.strip
      adding_a_wagon if menu == "1"
      wagon_uncoupling if menu == "2"
      action_menu if menu == "0"
    end
  end

  def adding_a_wagon # добавление вагона по типу к выбранному поезду
    puts "Выберите вагон который хотите добавить"
    wagon_enumeration
    selected_wagon = gets.strip.to_i
    self.active_wagon = @wagons[selected_wagon - 1]
    puts "Вы выбрали тип вагона #{active_wagon.type}"
    if active_wagon.type == active_train.type
      self.active_train.add_wagons(active_wagon)
      puts "Вагон добавлен"
      puts "Поезд: #{active_train.number}. Количество вагонов: #{active_train.wagons.length}"
    else
      puts "Тип вагона не совпадает с типом поезда, выберите другой вагон"
    end
  end

  def wagon_uncoupling # отцепляем по одному последнему вагону выбранного поезда
    self.active_train.unhook_wagons
    puts "Вагон отцеплен"
    puts "Поезд: #{active_train.number}. Количество вагонов: #{active_train.wagons.length}"
  end

  def info_menu
    puts "Введите 1, если хотите просматривать список станций"
    puts "Введите 2, если хотите просматривать список поездов на станции"
    puts "Введите 0, если хотите вернуться в главное меню"
    menu = gets.strip
    station_list if menu == "1"
    list_of_trains_at_the_station if menu == "2"
    action_menu if menu == "0"
  end


  def station_list # просматривать список станций
    station_listing
    info_menu
  end

  def list_of_trains_at_the_station # просматривает список поездов на выбранной станции
    puts "Выберите станцию на которой хотите посмотреть список поездов"
    station_listing
    station = gets.strip.to_i
    self.active_station = @stations[station - 1]
    puts "Выбрана станция #{active_station.name}."
    puts "Список поездов:"
    @active_station.trains.each_index do |index|
      print "№ #{index + 1}. "
      a = active_station.trains[index]
      puts "#{a.number}. Тип поезда: #{a.type}"
    end
    info_menu
  end

  def station_listing # перечисление станций
    @stations.each_index do |index|
      print "№ #{index + 1}. "
      st = stations[index]
      puts "#{st.name}"
    end
  end

  def wagon_enumeration # перечисление вагонов
    @wagons.each_index do |index|
      print "№ #{index + 1}."
      a = wagons[index]
      print "Тип вагона: #{a.type}"
      puts
    end
  end

  def train_enumeration # перечисление поездов
    @trains.each_index do |index|
      print "№ #{index + 1}. "
      st = @trains[index]
      print "#{st.number}. тип поезда: #{st.type}"
      puts
    end
  end

end

main = Main.new
main.start
