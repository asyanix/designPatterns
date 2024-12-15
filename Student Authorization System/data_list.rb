class Data_list
  def initialize(list)
    self.list = list
    self.selected = []
  end

  def select(index)
    unless index.is_a?(Integer) && index.between?(0, list.size - 1)
      raise ArgumentError, "Invalid index" 
    end
    self.selected << index unless self.selected.include?(index)
  end

  def get_selected
    self.selected.dup
  end

  def get_names
    names = ['№'] 
    column_names.each do |name| 
      names << name
    end
    names
  end

  def get_data
    data_table = [self.get_names]
    list.each_with_index.map do |item, index|
      data_table << [index + 1] + get_attributes(item)
    end
    Data_table.new(data_table)
  end

  private

  attr_reader :list
  attr_accessor :selected

  def get_attributes
    raise NotImplementedError, "Must be implemented!"
  end

  def column_names
    raise NotImplementedError, "Must be implemented!"
  end

  def list=(list) 
    unless list.is_a?(Array)
      raise ArgumentError, 'List must be an array.'
    end
    @list = list
  end
end