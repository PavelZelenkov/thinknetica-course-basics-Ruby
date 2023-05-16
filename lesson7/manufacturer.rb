module Manufacturer # модуль для указания производителя
  attr_reader :manufacturer_name
  
  def manufacturer_name(name)
    @manufacturer_name = name
  end

  def show_manufacturer
    @manufacturer_name
  end
end
