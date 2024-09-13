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

array = [-41, -12, 25, -655, 712, 81]
puts "Исходный массив: #{array}"
puts "Минимальный элемент массива равен #{min_element(array)}"
puts "Позиция первого положительного элемента равна #{first_positive_position(array)}"