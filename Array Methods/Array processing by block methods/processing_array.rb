class ProcArray
  attr_writer :array

  def initialize(array)
    @array = array
  end

  def array
    @array.dup 
  end

  def filter(&block)
    result = []
    @array.each do |element|
      if yield (element)
        result << element
      end
    end
    result
  end

end


