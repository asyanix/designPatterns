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
    raise NotImplementedError, "This method should be implemented in a subclass"
  end

  def get_data
    raise NotImplementedError, "This method should be implemented in a subclass"
  end

  private

  attr_reader :list
  attr_accessor :selected

  def list=(list) 
    unless list.is_a?(Array)
      raise ArgumentError, 'List must be an array.'
    end
    @list = list
  end
end