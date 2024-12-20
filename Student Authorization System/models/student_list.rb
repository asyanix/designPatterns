require_relative '../entities/student_short.rb'
require_relative '../entities/student.rb'
require_relative 'tree.rb'

class Student_list
  attr_writer :strategy, :file_path

  def initialize(file_path, strategy)
    self.file_path = file_path
    self.strategy = strategy
    self.student_list = []
  end

  def read
    self.student_list = self.strategy.read(file_path)
  end

  def write
    self.strategy.write(file_path, student_list)
  end  

  def get_student_by_id(id)
    student = student_list.find { |student| student.id == id }
    raise "Студент с ID #{id} не найден" if student.nil?
    student
  end

  def get_k_n_student_short_list(k, n, data_list = nil)
    raise ArgumentError, 'k и n должны быть неотрицательными числами' unless k.is_a?(Integer) && n.is_a?(Integer) && k > 0 && n > 0
    
    selected_student_list = student_list[(k - 1) * n, n] || []
    student_short_list = selected_student_list.map { |student| Student_short.init_with_student(student) }
    data_list ||= Data_list_student_short.new(student_short_list)
    data_list
  end

  def sort_by_initials
    student_list.sort_by!{|student| student.initials}
  end

  def add_student(student)
    begin
      unique?(student)
    rescue => ex
        raise ex
    end

    new_id = student_list.empty? ? 1 : student_list.max_by(&:id).id + 1 
    student.id = new_id
    self.student_list << student
  end 

  def replace_student_by_id(id, new_student)
    student_index = student_list.index { |student| student.id == id }
    if student_index.nil?
        raise "Студент с ID #{id} не найден"
    end
    student_list[student_index] = new_student
    new_student.id = id
  end 

  def delete_student_by_id(id)
    student_index = student_list.index { |student| student.id == id }
    if student_index.nil?
        raise "Студент с ID #{id} не найден"
    end
    student_list.delete_at(student_index)
  end

  def get_student_short_count
      student_list.size
  end

  private
  attr_accessor :student_list
  attr_reader :file_path, :strategy

  def unique?(student)
    tree = Tree.new
    self.student_list.each do |student|
        tree.add(student)
    end
    return !tree.find{|stud_node| stud_node == student}
end
end