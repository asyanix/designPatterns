require 'minitest/autorun'
require_relative 'processing_array.rb'

class ArrayTest < Minitest::Test
  def setup
    @test_array = ProcArray.new([545, 654, 923, 236, 221, 149, 378, 879, 321])
  end

  def test_array_filter
    result = @test_array.filter { |n| n.even? }
    expected_result = @test_array.array.filter { |n| n.even? }
    assert_equal(expected_result, result)
  end

  def test_array_include?
    result = @test_array.include?{ |x| x < 200 }
    expected_result = @test_array.array.any?{ |x| x < 200 }
    assert_equal(expected_result, result)
  end

  def test_array_member?
    result = @test_array.member?(923)
    expected_result = @test_array.array.member?(923)
    assert_equal(expected_result, result)
  end

  def test_array_sum
    result = @test_array.sum {|obj| obj * 5}
    expected_result = @test_array.array.sum {|obj| obj * 5}
    assert_equal(expected_result, result)
  end

  def test_array_chunk
    result = @test_array.chunk { |x| x > 500 }.to_a
    expected_result = @test_array.array.chunk { |x| x > 500 }.to_a
    assert_equal(expected_result, result)
  end

  def test_array_reduce
    result = @test_array.reduce(0) { |sum, n| sum + n }
    expected_result = @test_array.array.reduce(0) { |sum, n| sum + n }
    assert_equal(expected_result, result)
  end
end


