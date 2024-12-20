require_relative '../entities/student.rb'

# Узел дерева
class Node
  attr_accessor :value, :left, :right, :parent

  def initialize(value: nil, left: nil, right: nil, parent: nil)
    self.value = value
    self.left = left
    self.right = right
    self.parent = parent
  end
end

class Tree 
  include Enumerable
  attr_accessor :root

  def initialize
    self.root = nil
  end

  def each(&block)
    iterator(@root, &block)
  end

  # Обход дерева
  def iterator(node, &block)
    return if node.nil?

    iterator(node.left, &block)
    yield node.value
    iterator(node.right, &block)
  end

  # Добавление узла в дерево
  def add(value)
    node = Node.new(value: value)

    if node.nil?
      raise ArgumentError, 'Invalid argument'
    end

    if self.root.nil?
      self.root = node
    else
      insert(self.root, node)
    end
  end  

  private

  # Вставка узла в дерево
  def insert(root, node)
    if root.nil?
      return node
    end
  
    if node.value < root.value
      root.left = insert(root.left, node)
      root.left.parent = root
    else 
      root.right = insert(root.right, node)
      root.right.parent = root
    end
  
    root
  end  

end