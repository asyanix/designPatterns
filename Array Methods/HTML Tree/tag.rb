class Tag
  attr_accessor :name, :attributes, :children, :content

  def initialize(name: nil, attributes: {}, children: [], content: '')
    self.name = name
    self.attributes = attributes
    self.children = children
    self.content = content
  end

  # Добавляет дочерний тег в массив
  def add_child(child)
    children << child
  end

  # Возвращает имя тега
  def self.parse_name(string)
    string[1..-2].split.first                   
  end

  # Возвращает атрибуты тега
  def self.parse_attributes(string)
    attributes = {}
    string.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value|
      attributes[key] = value
    end
    attributes
  end

end