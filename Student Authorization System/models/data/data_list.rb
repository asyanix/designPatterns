class Data_list
  attr_accessor :count
  attr_writer :offset

  def initialize(list, offset = 0)
    self.list = list
    self.selected = []
    self.count = 0
    self.observers = []
    self.offset = offset
  end

  def select(number)
    self.selected << number unless self.selected.include?(number)
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
      data_table << [index + 1 + self.offset] + get_attributes(item)
    end
    Data_table.new(data_table)
  end

  def set_list(list)
    unless list.is_a?(Array)
      raise ArgumentError, 'List must be an array.'
    end
    self.list = list
  end

  def add_observer(observer)
    self.observers << observer
  end
  
  def notify
    return if observers.nil?
    observers.each do |observer|
      observer.set_table_params(self.get_names, self.count)
      observer.set_table_data(self.get_data)
    end
  end


  private

  attr_reader :list, :offset
  attr_accessor :selected, :observers

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