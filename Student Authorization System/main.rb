require_relative 'entities/student.rb'
require_relative 'entities/student_short.rb'
require_relative 'models/data/data_list_student_short.rb'
require_relative 'models/student_list_json.rb'
require_relative 'models/student_list_yaml.rb'
require_relative 'models/student_list.rb'

begin
  student1 = Student.new({ id: 1, surname: "Cheuzh", name: "Asya", patronymic: "Aslanbievna", git: "asyanix", phone: "89827484999", telegram: "asyanix", email: "asya_cheuzh@gmail.com", birthdate: Date.new(2005, 2, 22)})
  student2 = Student.new({id: 2, surname: "Nesvetaylov", name: "Vlad", patronymic: "Viktorovich", git: "saintJuuuly", email: "saing_juuuly@gmail.com", birthdate: Date.new(2002, 1, 24)})
  student3 = Student.new({id: 3, surname: "Ponomar", name: "Daria", patronymic: "Sergeevna", git: "pnmr3000", email: "pnmr3000@gmail.com", birthdate: Date.new(2004, 9, 16)})
  student4 = Student.new({id: 4, surname: "Ivanchenko", name: "Pavla", patronymic: "Andreevna", git: "eatdetey", email: "eatdetey@gmail.com", birthdate: Date.new(2004, 11, 12)})

  student_short1 = Student_short.init_with_string(1, "full_name: Nesvetaylov V. V., git: saintJuuuly, email: saing_juuuly@gmail.com")
  student_short2 = Student_short.init_with_string(2, "full_name: Cheuzh A. A., git: asyanix, telegram: asyanix")
  student_short3 = Student_short.init_with_string(3, "full_name: Ponomar D. S., git: pnmr3000, email: pnmr3000@gmail.com")
  student_short4 = Student_short.init_with_string(4, "full_name: Ivanchenko P. A., git: eatdetey, email: eatdetey@gmail.com")
  
  student_short5 = Student_short.init_with_string(5, "full_name: Ivanov I. I., git: ivanovIvan, telegram: ivanovIvan")
  student_short6 = Student_short.init_with_string(6, "full_name: Vladimirov V. V., git: vladimirovVladimir, email: vladimirov@gmail.com")
  student_short7 = Student_short.init_with_string(7, "full_name: Mihailov M. M., git: mihailovMihail, email: mihailovMihail@gmail.com")

  puts("\nПроверка Data_list_student_short до изменения:")
  student_short_list = Data_list_student_short.new([student_short1, student_short2, student_short3, student_short4])
  table = student_short_list.get_data
  puts table

  puts("\nПроверка Data_list_student_short после изменения:")
  new_student_short_list = student_short_list.set_list([student_short5, student_short6, student_short7])
  table = student_short_list.get_data
  puts table

  students_list = Student_list_JSON.new('Student Authorization System/models/data/student.json')
  students_list.read
  students_list.sort_by_initials
  puts "\nОтсортированные студенты в students_list, начиная со второго:"
  data_list = students_list.get_k_n_student_short_list(1, 2)
  data = data_list.get_data
  (0..data.row_count - 1).each do |index|
      puts "#{data.get_by_index(index, 0)}, #{data.get_by_index(index, 1)}, #{data.get_by_index(index, 2)}, #{data.get_by_index(index, 3)}"   
  end
  test_student = Student.new({id: 4, surname: "Ivanchenko", name: "Pavla", patronymic: "Andreevna", git: "eatdetey", email: "eatdetey@gmail.com", birthdate: Date.new(2004, 11, 12)})

  puts "\nДобавление нового студента:"
  students_list.add_student(test_student)
  students_list.sort_by_initials
  data_list = students_list.get_k_n_student_short_list(1, students_list.get_student_short_count)
  data = data_list.get_data
  (0..data.row_count - 1).each do |index|
      puts "#{data.get_by_index(index, 0)}, #{data.get_by_index(index, 1)}, #{data.get_by_index(index, 2)}, #{data.get_by_index(index, 3)}"   
  end

  puts "\nУдаление студента по id 4:"
  students_list.delete_student_by_id(4)
  data_list = students_list.get_k_n_student_short_list(1, students_list.get_student_short_count)
  data = data_list.get_data
  (0..data.row_count - 1).each do |index|
      puts "#{data.get_by_index(index, 0)}, #{data.get_by_index(index, 1)}, #{data.get_by_index(index, 2)}, #{data.get_by_index(index, 3)}"   
  end

  puts "\nЗамена студента с id 3:"
  students_list.replace_student_by_id(3, test_student)
  data_list = students_list.get_k_n_student_short_list(1, students_list.get_student_short_count)
  data = data_list.get_data
  (0..data.row_count - 1).each do |index|
      puts "#{data.get_by_index(index, 0)}, #{data.get_by_index(index, 1)}, #{data.get_by_index(index, 2)}, #{data.get_by_index(index, 3)}"   
  end

  puts "\nПроверка Students_list_YAML"
  students_list_yaml = Student_list_YAML.new('Student Authorization System/models/data/student.yaml')
  students_list_yaml.add_student(student1)
  students_list_yaml.add_student(student2)
  students_list_yaml.add_student(student3)
  students_list_yaml.add_student(student4)
  students_list_yaml.write
  students_list_yaml.read
  data_list = students_list_yaml.get_k_n_student_short_list(1, students_list.get_student_short_count)
  data = data_list.get_data
  (0..data.row_count - 1).each do |index|
      puts "#{data.get_by_index(index, 0)}, #{data.get_by_index(index, 1)}, #{data.get_by_index(index, 2)}, #{data.get_by_index(index, 3)}"  
  end
rescue ArgumentError => e
  puts e.message
end