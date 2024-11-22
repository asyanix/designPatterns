require_relative 'student.rb'
require_relative 'student_short.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", birthdate: Date.new(2005, 2, 22)})
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly", email: "saing_juuuly@gmail.com", birthdate: Date.new(2002, 1, 24)})
  student3 = Student.new({id: 3, surname: "Ponomar", name: "Daria", patronymic: "Sergeevna", git: "pnmr3000", email: "pnmr3000@gmail.com", birthdate: Date.new(2004, 9, 17)})
  puts student1, student2, student3
rescue ArgumentError => e
  puts e.message
end