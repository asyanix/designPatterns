class ArrayBlockMethods
  attr_accessor :array
  private_class_method :new

  def initialize(array)
    @array = array
  end

  # Инициализация массива путем чтения из файла
  def self.init_with_file(file_path)
    return nil unless File.exist?(file_path)
    array = read_array_from_file(file_path)

    return nil if array.empty? 
    new(array)
  end

  # Вывести индексы массива в том порядке, 
  # в котором соответствующие им элементы образуют убывающую последовательность.
  def descending_indices()
    @array.each_with_index
         .sort_by { |value, _index| -value } 
         .map { |_value, index| index }   
  end

  # Найти элементы, расположенные между первым и вторым максимальным.
  def elements_between_max()
    max1, max2 = @array.max(2)

    max1_index = @array.index(max1)
    max2_index = @array.index(max2)

    min_index = [max1_index, max2_index].min
    max_index = [max1_index, max2_index].max

    array[(min_index + 1)..(max_index - 1)]
  end

  # Вывод массива
  def print_array()
    puts @array.join(" ")
  end

  private

  # Чтение массива из файла
  def self.read_array_from_file(file_path)
    begin
      File.readlines(file_path).map do |line|
        Integer(line.strip)
      rescue ArgumentError
        nil
      end.compact
    rescue StandardError => e
      puts "Ошибка чтения файла: #{e.message}"
      nil
    end
  end
end