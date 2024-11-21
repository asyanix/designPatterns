require_relative 'processing_array.rb'

example_array = ProcArray.new([545, 654, 923, 236, 221, 149, 378, 879, 321])
puts example_array.array.join(" ") 

result = example_array.filter {|n| n.even?}
puts result.join(" ") 
