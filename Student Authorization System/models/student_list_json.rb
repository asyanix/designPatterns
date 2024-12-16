require 'json'
require_relative 'student_list.rb'

class Student_list_JSON < Student_list    
  private
  
  def write_empty_file(file_path)
    File.write(file_path, [].to_json)
  end

  def get_student_hashes(content)
    JSON.parse(content, symbolize_names: true)
  end

  def generate_content(content)
    JSON.pretty_generate(content)
  end
end  