require_relative 'data_list.rb'
require_relative 'data_table.rb'

class Data_list_student_short < Data_list
  def initialize(list)
    super(list)
  end

  def get_names
    ["full_name", "git", "contact"]
  end

  def get_data
    data_table = [["id"] + self.get_names]
    list.each_with_index.map do |student_short, index|
      data_table <<
      [
          index + 1,
          student_short.full_name,
          student_short.git,
          student_short.contact
      ]
    end
    Data_table.new(data_table)
  end
end