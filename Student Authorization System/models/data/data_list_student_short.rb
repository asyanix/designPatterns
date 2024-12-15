require_relative 'data_list.rb'
require_relative 'data_table.rb'

class Data_list_student_short < Data_list
  def initialize(list)
    super(list)
  end

  private

  def column_names
    ["full_name", "git", "contact"]
  end

  def get_attributes(student_short)
    [student_short.full_name,
    student_short.git,
    student_short.contact]
  end
end