class Data_table

  def initialize(table)
    self.table = table
  end

  def get_by_index(row_index, column_index)
    unless table.dig(row_index, column_index)
      raise IndexError, "Index is out of range" 
    end
    table[row_index][column_index]
  end 

  def row_count
    table.size
  end

  def column_count
    if table.empty? 
      return 0
    else
      return table[0].size
    end
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