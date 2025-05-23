=begin
ЗАДАНИЕ - Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
(Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
Алгоритм опредления високосного года: docs.microsoft.com
=end

leap_year = {1 => 31, 2 => 29, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}
leap_year_months = leap_year.merge(2 => 28)

puts "Введите число: "
number = gets.to_i

puts "Введите месяц: "
month = gets.to_i

puts "Введите год: "
year = gets.to_i

puts "Дата #{number}.#{month}.#{year}"

if is_leap_year = year % 4 == 0 && year % 100 == 0 && year % 400 == 0
  puts "Год високосный"
else
  puts "Год не високосный"
end

num_day = (is_leap_year ? leap_year : leap_year_months).values[1..month - 1].sum

puts "Порядковый номер даты: #{num_day + number}"
