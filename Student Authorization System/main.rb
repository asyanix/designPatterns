require_relative 'student_class.rb'
require_relative 'student_short.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com"})
  puts student1
rescue ArgumentError => e
  puts e.message
end

begin
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly", email: "saing_juuuly@gmail.com"})
  puts student2.get_info
rescue ArgumentError => e
  puts e.message
end

begin
  student3 = Student_short.init_with_student(student1)
  puts student3
rescue ArgumentError => e
  puts e.message
end

begin
  student4 = Student_short.init_with_string(4, "full_name: Paradeevich A. K., git: paradeevich, email: paradeevich@gmail.com")
  puts student4.get_info
rescue ArgumentError => e
  puts e.message
end