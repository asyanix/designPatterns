class Data_table
  def initialize(table)
    self.table = table
  end

  def get_by_index(row_index, column_index)
    unless row_index >= 0 && row_index < table.size && column_index >= 0 && column_index < table[0].size
      return nil
      raise IndexError, "Index is out of range" 
    end
    table[row_index][column_index]
  end 

  def row_count
    self.table.size
  end

  def column_count
    if self.table.empty? 
      return 0
    else
      return table[0].size
    end
  end

  def to_s
    result = []
    self.table.each do |row|
      row_string = row.join(' ')
      result << "#{row_string}"
    end
    result.join("\n")
  end

  private

  attr_reader :table

  def table=(table) 
    unless table.is_a?(Array) && table.all? { |row| row.is_a?(Array) }
      raise ArgumentError, 'Table must be a two-dimensional array.'
    end
    @table = table
  end
end