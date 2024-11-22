class Traversal
  include Enumerable

  attr_accessor :root

  def initialize(root)
    self.root = root
  end

  # Общий метод для перечисления элементов
  def each
    enumerator = bfs_traversal # По умолчанию BFS
    enumerator.each do |element|
      yield element
    end
  end

  # Обход в ширину
  def bfs_traversal
    Enumerator.new do |yielder|
      enum_queue = [self.root]
      until enum_queue.empty?
        element = enum_queue.shift
        yielder << element
        enum_queue.concat element.children if element.children
      end
    end
  end

  # Обход в глубину
  def dfs_traversal
    Enumerator.new do |yielder|
      enum_stack = [self.root]
      until enum_stack.empty?
        element = enum_stack.pop
        yielder << element
        enum_stack.concat element.children.reverse if element.children
      end
    end
  end
end
