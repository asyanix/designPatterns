require_relative 'student_class.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", git: "asyanix"})
  student1.validate
  student1.show_info
rescue ArgumentError => e
  puts e.message
end

begin
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly"})
  student2.validate
  student2.show_info
rescue ArgumentError => e
  puts e.message
end

begin
  student3 = Student.new(id: 3, surname: "Kuznetsov", name: "Dmitriy", patronymic: "Vladimirovich", email: "kuznetsoff@gmail.com")
  student3.validate
  student3.show_info
rescue ArgumentError => e
  puts e.message
end