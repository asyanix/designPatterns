require_relative 'student_class.rb'
require_relative 'student_short.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com"})
  puts student1.get_info
rescue ArgumentError => e
  puts e.message
end

begin
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly"})
  puts student2.get_info
rescue ArgumentError => e
  puts e.message
end

begin
  student3 = Student.new(id: 3, surname: "Kuznetsov", name: "Dmitriy", patronymic: "Vladimirovich", email: "kuznetsoff@gmail.com")
  puts student3.get_info
rescue ArgumentError => e
  puts e.message
end

begin
  student4 = Student_short.init_with_student(student1)
  puts "#{student4.id}, #{student4.full_name}, #{student4.git}, #{student4.contact}"
rescue ArgumentError => e
  puts e.message
end

begin
  student5 = Student_short.init_with_string(4, "full_name: Paradeevich A.K., git: paradeevich, email: paradeevich@gmail.com")
  puts "#{student5.id}, #{student5.full_name}, #{student5.git}, #{student5.contact}"
rescue ArgumentError => e
  puts e.message
end