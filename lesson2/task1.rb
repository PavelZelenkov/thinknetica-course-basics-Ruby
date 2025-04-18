=begin 
ЗАДАНИЕ - Сделать хеш, содержащий месяцы и количество дней в месяце.
В цикле выводить те месяцы, у которых количество дней ровно 30.
=end

months = {january: 31, 
february: 28, 
march: 31, 
april: 30, 
may: 31, 
june: 30, 
july: 31, 
august: 31, 
september: 30, 
october: 31, 
november: 30, 
december: 31
}

month = months.select {|key, value| value == 30}

month.each do |key, value|
  puts "Month: #{key}"
end
