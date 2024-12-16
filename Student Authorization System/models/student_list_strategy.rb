require 'json'
require 'yaml'

class Students_list_strategy
  private
  def write_empty_file(file_path)
    raise NotImplementedError, 'Must be implemented!'
  end

  def get_student_hashes(content)
    raise NotImplementedError, 'Must be implemented!'
  end

  def generate_content(content)
    raise NotImplementedError, 'Must be implemented!'
  end
end

class Student_list_YAML_strategy < Students_list_strategy   
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

class Student_list_JSON_strategy < Students_list_strategy    
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