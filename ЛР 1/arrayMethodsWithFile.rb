# Функция для поиска минимального элемента в массиве
def min_element(array)
  return nil if array.length == 0
  min = array[0]
  for item in array
    min = item if item < min
  end
  return min
end

# Функция для поиска позиции первого положительного элемента массива
def first_positive_position(array)
  i = 0
  while i < array.size do
    if array[i] >= 0
      position = i 
      return position
    end
    i += 1
  end
  return -1
end

if ARGV.length != 2
  puts "Ошибка: Необходимо ввести метод работы с массивом и путь к файлу для чтения массива."
else
  method_array = ARGV[0].to_i
  path_file = ARGV[1]

  file = File.new(path_file)
  array = file.readlines.map(&:chomp).map(&:to_i)

  case method_array
    when 1
      puts "Минимальный элемент массива равен #{min_element(array)}"
    when 2
      puts "Позиция первого положительного элемента равна #{first_positive_position(array)}"
  end
end
