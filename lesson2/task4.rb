# ЗАДАНИЕ - Заполнить хеш гласными буквами, где значением будет являться порядковый номер буквы в алфавите (а - 1).

arr1 = [] # массив для букв и номеров
arr2 = [] # массив для определения массивов в массиве
arr3 = [] # объединенные массивы

('a'..'z').each.with_index { |i, index| arr1.push(i, index + 1) }

26.times do
  arr2 << 2
end

arr2.each { |m| arr3.push(arr1.shift(m)) } # объединить два массива

hash = arr3.to_h # преобразовать массив в хеш

hash2 = {} # хеш для гласных букв и их порядкового номера в алфавите

hash.each do |key, value| # добавляем гласные буквы и их ключи
  if key == "a"
    hash2[key] = value
  elsif key == "e"
    hash2[key] = value
  elsif key == "i"
    hash2[key] = value
  elsif key == "o"
    hash2[key] = value
  elsif key == "u"
    hash2[key] = value
  elsif key == "y"
    hash2[key] = value
  end
end

puts hash2.inspect # результат
