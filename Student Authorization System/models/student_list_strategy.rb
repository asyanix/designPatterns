require 'json'
require 'yaml'

class Students_list_strategy
  private
  def read(file_path)
    raise NotImplementedError, 'Must be implemented!'
  end

  def write(file_path, student_list)
    raise NotImplementedError, 'Must be implemented!'
  end
end

class Student_list_YAML_strategy < Students_list_strategy   
  def read(file_path)
    content = File.read(file_path)
    student_hashes = YAML.safe_load(content, symbolize_names: true, permitted_classes: [Date, Symbol])
    student_list = student_hashes.map do |student_hash|
      Student.new(**student_hash)
    end
    student_list
  end

  def write(file_path, student_list)
    content = student_list.map{|student| student.to_h}
    File.write(file_path, content.to_yaml)
  end
end

class Student_list_JSON_strategy < Students_list_strategy    
  def read(file_path)
    content = File.read(file_path)
    student_hashes = JSON.parse(content, symbolize_names: true)
    student_list = student_hashes.map do |student_hash|
      Student.new(**student_hash)
    end
    student_list
  end

  def write(file_path, student_list)
    content = student_list.map{|student| student.to_h}
    File.write(file_path, JSON.pretty_generate(content))
  end
end  