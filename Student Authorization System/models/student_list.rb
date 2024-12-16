require_relative '../entities/student_short.rb'
require_relative '../entities/student.rb'
require_relative 'data/data_list_student_short.rb'

class Student_list
  attr_writer :strategy

  def initialize(file_path, strategy)
    self.file_path = file_path
    @strategy = strategy
    self.student_list = []
    unless File.exist?(file_path)
      @strategy.write_empty_file(file_path)
    end
  end

  def strategy=(strategy)
    @strategy = strategy
  end

  def read
    content = File.read(file_path)
    student_hashes = @strategy.get_student_hashes(content)
    self.student_list = student_hashes.map do |student_hash|
      Student.new(**student_hash)
    end
  end

  def write
    content = student_list.map{|student| student.to_h}
    File.write(file_path, @strategy.generate_content(content))
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
  attr_accessor :file_path, :student_list
end