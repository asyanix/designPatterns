require 'yaml'
require_relative 'student_list.rb'

class Student_list_YAML < Student_list   
    private

    def write_empty_file(file_path)
      File.write(file_path, [].to_yaml)
    end

    def get_student_hashes(content)
      YAML.safe_load(content, symbolize_names: true, permitted_classes: [Date, Symbol])
    end

    def generate_content(content)
      content.to_yaml
    end
end