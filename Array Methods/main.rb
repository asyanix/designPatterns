require_relative 'methods_block_argument.rb'

begin
  new_array = ArrayBlockMethods.init_with_file("Array Methods/array.txt")
  puts "Исходный массив:"
  new_array.print_array()
rescue ArgumentError => e
  puts e.message
end

while true
  puts "\nВыберите действие, которое хотите выполнить:"
  puts "1. Задача 4: Вывести индексы массива в том порядке, в котором соответствующие им элементы образуют убывающую последовательность."
  puts "2. Задача 16: Необходимо найти элементы, расположенные между первым и вторым максимальным."
  puts "3. Задача 28: Необходимо найти элементы, расположенные между первым и вторым максимальным."
  puts "4. Задача 40: Необходимо найти минимальный четный элемент."
  puts "5. Задача 52: Для введенного числа построить список всех его простых делителей, причем если введенное число делится на простое число p в степени α, то в итоговом списке число p должно повторятся α раз. Результирующий список должен быть упорядочен по возрастанию."
  puts "6. Выход из программы\n"

  choice = gets.chomp

  case choice
  when '1'
    descending_indices = new_array.descending_indices()
    puts "Результат задачи 4:"
    puts descending_indices.join(" ")
  when '6'
    puts "Выход из программы."
    break
  else
    puts "Неверный выбор, попробуйте снова."
  end
end