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

  def chunk(&block)
		Enumerator.new do |y|
			collections = []
			current_group = []
			previous_value = nil
			@array.each do |element|
				current_value = yield element
				if previous_value.nil? || previous_value != current_value
					collections << [current_value, []]
					current_group = collections.last.last
				end
				current_group << element
				previous_value = current_value
			end
			collections.each do |group|
			y << group
			end
		end
	end

end


