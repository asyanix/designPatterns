require_relative 'student_class.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", git: "asyanix"})
  student1.show_info
rescue ArgumentError => e
  puts e.message
end

begin
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", phone: "89728946758", telegram: "saintJuuuly", telegram: "saintJuuuly", email: "vlad_nesv@gmail.com", git: "святойИюююль"})
  student2.show_info
rescue ArgumentError => e
  puts e.message
end

begin
  student3 = Student.new(id: 4, surname: "Kuznetsov", name: "Dmitriy", patronymic: "Vladimirovich", git: "kuznetsoff", email: "kuznetsoff!gmail.com")
  student3.show_info
rescue ArgumentError => e
  puts e.message
end