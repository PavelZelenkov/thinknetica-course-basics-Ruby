# ЗАДАНИЕ - Идеальный вес

print "Введите ваше имя: "
name = gets.strip.capitalize

print "Введите ваш рост: "
height = gets.chomp

ideal_weight = (height.to_i - 110) * 1.15

if  ideal_weight > 0
  puts "Приветствую #{name}, ваш идеальный вес #{ideal_weight}"
else
  puts "Ваш вес уже оптимальный"
end
