puts "Введите команду для Ruby:"
ruby_command = gets.chomp

puts "Введите команду для операционной системы:"
os_command = gets.chomp

begin
  eval(ruby_command)
  system(os_command)
rescue StandardError => e
  puts "Произошла ошибка при выполнении команд: #{e.message}"
end
