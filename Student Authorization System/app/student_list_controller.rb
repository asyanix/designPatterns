require_relative 'student_list_view.rb'
require_relative '../models/student_list.rb'
require_relative '../models/student_list_strategy.rb'
require_relative '../models/data/data_list_student_short.rb'


class Student_list_controller
  private attr_accessor :view, :student_list, :data_list

  def initialize(view)
    self.view = view
    begin
      self.student_list = Student_list.new('Student Authorization System/models/data/student.json', Student_list_JSON_strategy.new)
      self.student_list.read
      self.data_list = Data_list_student_short.new([])
      self.data_list.add_observer(self.view)
    rescue Exception => ex
      self.view.show_error_message("Data error: #{ex.message}")
    end
  end

  def refresh_data
    # Контроллер вызывает метод get_k_n_student_short_list у класса Students_list
    # Объект data_list_student_short сохраняется в отдельном поле
    self.student_list.get_k_n_student_short_list(self.view.current_page, self.view.items_per_page - 1, self.data_list)
    self.data_list.count = self.student_list.get_student_short_count
    # У созданного объекта data_list_student_short вызываем метод notify
    self.data_list.notify
  end

  def create
    puts "Создание записи"
  end

  def update(indexes)
    return if indexes.nil?
    puts "Изменение записи с индексом: #{number}"
  end

  def delete(indexes)
    return if indexes.nil?
    puts "Удаление записей с индексами #{indexes}"
  end

  def sort_table_by_column
    self.student_list.sort_by_initials
    self.data_list.notify
  end
end