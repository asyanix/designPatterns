require_relative 'student.rb'
require_relative 'tree.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", birthdate: Date.new(2005, 2, 22)})
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly", email: "saing_juuuly@gmail.com", birthdate: Date.new(2002, 1, 24)})
  student3 = Student.new({id: 3, surname: "Ponomar", name: "Daria", patronymic: "Sergeevna", git: "pnmr3000", email: "pnmr3000@gmail.com", birthdate: Date.new(2004, 9, 16)})
  student4 = Student.new({id: 4, surname: "Ivanchenko", name: "Pavla", patronymic: "Andreevna", git: "eatdetey", email: "eatdetey@gmail.com", birthdate: Date.new(2004, 11, 12)})

  # puts student1, student2, student3

  tree = Tree.new
  tree.add(student1)
  tree.add(student2)
  tree.add(student3)
  tree.add(student4)

  tree.each do |node|
    puts node.name 
  end
rescue ArgumentError => e
  puts e.message
end