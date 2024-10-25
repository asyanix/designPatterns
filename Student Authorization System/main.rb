require_relative 'student_class.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com"})
  student1.validate
  puts student1.to_s
rescue ArgumentError => e
  puts e.message
end

begin
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly"})
  student2.validate
  puts student2.to_s
rescue ArgumentError => e
  puts e.message
end

begin
  student3 = Student.new(id: 3, surname: "Kuznetsov", name: "Dmitriy", patronymic: "Vladimirovich", email: "kuznetsoff@gmail.com")
  student3.validate
  puts student3.to_s
rescue ArgumentError => e
  puts e.message
end