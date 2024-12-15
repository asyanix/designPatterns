require_relative 'student.rb'
require_relative 'tree.rb'
require_relative 'student_short.rb'
require_relative 'data_list_student_short.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", birthdate: Date.new(2005, 2, 22)})
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly", email: "saing_juuuly@gmail.com", birthdate: Date.new(2002, 1, 24)})
  student3 = Student.new({id: 3, surname: "Ponomar", name: "Daria", patronymic: "Sergeevna", git: "pnmr3000", email: "pnmr3000@gmail.com", birthdate: Date.new(2004, 9, 16)})
  student4 = Student.new({id: 4, surname: "Ivanchenko", name: "Pavla", patronymic: "Andreevna", git: "eatdetey", email: "eatdetey@gmail.com", birthdate: Date.new(2004, 11, 12)})

  student_short1 = Student_short.init_with_string(1, "full_name: Nesvetaylov V. V., git: saintJuuuly, email: saing_juuuly@gmail.com")
  student_short2 = Student_short.init_with_string(2, "full_name: Cheuzh A. A., git: asyanix, telegram: asyanix")
  student_short3 = Student_short.init_with_string(3, "full_name: Ponomar D. S., git: pnmr3000, email: pnmr3000@gmail.com")
  student_short4 = Student_short.init_with_string(4, "full_name: Ivanchenko P. A., git: eatdetey, email: eatdetey@gmail.com")

  puts("\nПроверка Data_list_student_short:")
  student_short_list = Data_list_student_short.new([student_short1, student_short2, student_short3, student_short4])
  table = student_short_list.get_data
  puts table
  
  # tree = Tree.new
  # tree.add(student1)
  # tree.add(student2)
  # tree.add(student3)
  # tree.add(student4)

  # tree.each do |node|
  #   puts node.name 
  # end
rescue ArgumentError => e
  puts e.message
end