class Data_table

  def initialize(data)
    self.data = data
  end

  def get_by_index(row_index, column_index)
    unless data.dig(row_index, column_index)
      raise IndexError, "Index is out of range" 
    end
    data[row_index][column_index]
  end 

  def row_count
    data.size
  end

  def column_count
    if data.empty? 
      return 0
    else
      return data[0].size
    end
  end

  private

  attr_reader :data
  
  def data=(data) 
    unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
      raise ArgumentError, 'Data must be a two-dimensional array.'
    end
    @data = data
  end
end