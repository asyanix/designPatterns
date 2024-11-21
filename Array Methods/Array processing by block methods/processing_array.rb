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

  def include?(&block)
		@array.each do |element|
			return true if yield element
		end
		return false
	end

  def member?(object)
    @array.each do |element|
      return true if element == object
    end
    return false
  end

  def sum(&block)
		sum = 0
		@array.each do |element|
				sum += yield element
		end
		sum
	end

  def reduce(start = @array[0],&block)
    accum = start
    @array.each do |element|
      accum = yield(accum, element)
    end
    accum
  end

end


