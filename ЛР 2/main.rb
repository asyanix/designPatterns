require_relative 'student_class.rb'

student1 = Student.new(id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", git: "asyanix")
student2 = Student.new(id: 2, surname: "Kirkorov", name: "Philipp", patronymic: "Bedrosovich")
student3 = Student.new(id: 3, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", phone: "89728946758", telegram: "saintJuuuly")

student1.show_info()
student2.show_info()
student3.show_info()