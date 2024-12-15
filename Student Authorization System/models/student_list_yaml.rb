require 'yaml'
require_relative '../entities/student_short.rb'
require_relative '../entities/student.rb'
require_relative 'data/data_list_student_short.rb'

class Student_list_YAML

    def initialize(file_path)
        self.file_path = file_path
        self.students = []
        unless File.exist?(file_path)
            File.write(file_path, [].to_yaml)
        end
    end    

    def read
        content = File.read(file_path)
        student_hashes = YAML.safe_load(content, symbolize_names: true, permitted_classes: [Date, Symbol])
        self.students = student_hashes.map do |student_hash|
            Student.new(**student_hash)
        end
    end    

    def write
        content = students.map{|student| student.to_h}
        File.write(file_path, content.to_yaml)
    end    

    def get_student_by_id(id)
        student = students.find { |student| student.id == id }
        raise "Студент с ID #{id} не найден" if student.nil?
        student
    end

    def get_k_n_student_short_list(k, n, data_list = nil)
        raise ArgumentError, 'k и n должны быть неотрицательными числами' unless k.is_a?(Integer) && n.is_a?(Integer) && k > 0 && n > 0
        selected_students = students[(k - 1) * n, n] || []
        student_short_list = selected_students.map { |student| Student_short.init_with_student(student) }
        data_list ||= Data_list_student_short.new(student_short_list)
        data_list
    end

    def sort_by_initials
        students.sort_by!{|student| student.initials}
    end

    def add_student(student)
        new_id = students.empty? ? 1 : students.max_by(&:id).id + 1 
        student.id = new_id
        self.students << student
    end

    def replace_student_by_id(id, new_student)
        student_index = students.index { |student| student.id == id }
        if student_index.nil?
            raise "Студент с ID #{id} не найден"
        end
        students[student_index] = new_student
        new_student.id = id
    end

    def delete_student_by_id(id)
        student_index = students.index { |student| student.id == id }
        if student_index.nil?
            raise "Студент с ID #{id} не найден"
        end
        students.delete_at(student_index)
    end

    def get_student_short_count
        students.size
    end 

    private
    attr_accessor :file_path, :students
end