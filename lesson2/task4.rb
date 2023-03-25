# ЗАДАНИЕ - Заполнить хеш гласными буквами, где значением будет являться порядковый номер буквы в алфавите (а - 1).

hash = ('a'..'z').map.with_index { |letter, index| [letter, index]}.to_h

hash2 = {}

hash.each do |key, value|
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

puts hash2
