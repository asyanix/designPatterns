require_relative 'data_list.rb'
require_relative 'data_table.rb'

class Data_list_student_short < Data_list
  def initialize(list)
    super(list)
  end

  def get_names
    list.first.attributes.keys.select { |key| key != :id }.map(&:to_s)
  end

  def get_data
    data = []
    headers = ["ID"] + get_names
    list.each_with_index do |student, index|
      row = [index + 1] 
      student.attributes.each do |key, value|
        next if key == :id  
        row << value  
      end
      data << row
    end
    Data_table.new(data)
  end
end