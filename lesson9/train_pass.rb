class PassengerTrain < Train

  validate :number, :presence
  validate :number, :format, /^\w{3}(.\w{2})?$/.freeze
  
  def initialize(number)
    @type = 'pass'
    super
  end
end
