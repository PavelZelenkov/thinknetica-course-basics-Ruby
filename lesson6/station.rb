class Station # Станция
  include InstanceCounter

  attr_reader :trains, :name
  
  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.all << self
    register_instance
  end
  
  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @all ||= []
  end

  def add_train(train) # добавление поездов из класса Train
    trains << train
  end

  def send_train(train) # отправление поездов
    trains.delete(train)
  end

  def show_train # возвращает список всех поездов на станции
    trains.each { |i| puts i.type }
  end

  def train_type(type) # возвращает список всех поездов на станции по типу
    trains.select { |tr| tr.type == "#{type}" }
  end

  protected

  def validate!
    errors = []
    errors << "Название станции не должно быть пустым" if name == ''
    raise errors.join('.') unless errors.empty?
  end
end
