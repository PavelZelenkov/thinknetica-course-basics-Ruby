# ЗАДАНИЕ - Квадратное уравнение

puts "Введите коэффициент А:"
a = gets.to_i

puts "Введите коэффициент В:"
b = gets.to_i

puts "Введите коэффициент С:"
c = gets.to_i

d = b**2 - 4 * a * c

puts d

if d < 0
  puts "Корней нет"
elsif d == 0
  puts "Один корень"
else
  puts "Дискриминант #{d}"
  puts "Х1 = #{(-b + Math.sqrt(d)) / (2 * a)}"
  puts "Х2 = #{(-b - Math.sqrt(d)) / (2 * a)}"
end
