# ЗАДАНИЕ - Заполнить массив числами от 10 до 100 с шагом 5

arr = []

a = 5

loop do
  a = a + 5
  arr << a
  if a == 100
    break
  end
end

puts arr.inspect
