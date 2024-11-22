require_relative 'tag.rb'

class Tree
  attr_accessor :root

  def initialize(html_code)
    self.root = self.import_HTML(html_code)
  end
  
  # Парсинг HTML кода 
  def import_HTML(html_code)
    tags = [] 
    parse_tags = html_code.scan(/<[^>]+>|[^<]+/)
    parse_tags.each do |element| 
      element.strip!
      
      if is_open_tag?(element)
        processing_open_tag(element, tags)
      elsif is_closed_tag?(element)
        processing_closed_tag(element, tags)
      elsif is_single_tag?(element)
        processing_single_tag(element, tags)
      else 
        processing_content(element, tags)
      end
    end
    self.root = tags.first if tags.length > 0
  end
  
  private

  # Является ли элемент открывающим тегом
  def is_open_tag?(element)
    element.start_with?('<') && !element.start_with?('</') && !element.end_with?('/>')
  end  
  
  # Является ли элемент закрывающимся тегом
  def is_closed_tag?(element)
    element.start_with?('</')
  end  
  
  # Является ли элемент одиночным тегом
  def is_single_tag?(element)
    element.start_with?('<') && element.end_with?('/>')
  end
  
  # Обработка открывающего тега
  def processing_open_tag(element, tags)
    tag_name = Tag.parse_name(element)
    tag_attributes = Tag.parse_attributes(element)
    new_tag = Tag.new(name: tag_name, attributes: tag_attributes) 

    if tags.last
      tags.last.add_child(new_tag)
    else 
      self.root = new_tag
    end

    tags << new_tag
  end

  # Обработка закрывающего тега
  def processing_closed_tag(element, tags)
    if Tag.parse_name(element) == tags.last.name
      tags.pop
    end
  end

  # Обработка одиночного тега
  def processing_single_tag(element, tags)
    tag_name = Tag.parse_name(element)
    tag_attrs = Tag.parse_attributes(element)
    new_tag = Tag.new(name: tag_name, attrs: tag_attrs)

    if tags.last
      tags.last.add_child(new_tag)
    else 
      self.root = new_tag
    end
  end

  # Обработка содержимого тега
  def processing_content(element, tags)
    tags.last.content += element if element
  end

end