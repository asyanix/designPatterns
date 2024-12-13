class Data_list
  def initialize(list)
    self.list = list
    @selected = []
  end
  
  def select(index)
    unless index.is_a?(Integer) && index.between?(0, list.size - 1)
      raise ArgumentError, "Invalid index" 
    end
    @selected << index unless @selected.include?(index)
  end

  def get_selected
    @selected.dup
  end

  def get_names
    raise NotImplementedError, "This method should be implemented in a subclass"
  end

  def get_data
    raise NotImplementedError, "This method should be implemented in a subclass"
  end

  private

  attr_reader :list
  
  def list=(list) 
    unless list.is_a?(Array)
      raise ArgumentError, 'List must be an array.'
    end
    @list = list
  end
end