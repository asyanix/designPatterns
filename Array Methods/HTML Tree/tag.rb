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

  # Вывод тега
  def to_s
    if single?
      return single
    else 
      return opening
    end
  end
  
  # Формирование открывающегося тега
  def opening
    "<#{self.name}#{self.attributes.any? ? self.attributes.map{|k,v| "#{k}=\"#{v}\""}.join(' ') : ''}>#{self.content.length > 0 ? self.content : ''}"
  end

  # Формирование закрывающегося тега
  def closing
    "<#{self.name}>"
  end

  # Формирование одиночного тега
  def single
    "<#{self.name} #{self.attributes.map{|k,v| "#{k}=\"#{v}\""}.join(' ')}/>"
  end

  # Количество потомков
  def count_of_children
    children.length
  end

  # Является ли тег одиночным
  def single?
    ['img', 'form'].include?(self.name)
  end
end