require_relative 'student_class.rb'

class Student_short
  attr_accessor :id
  attr_reader :full_name, :git, :contact
  private_class_method :new
  
  def initialize(id, full_name, git, contact)
    self.id = id
    self.full_name = full_name
    self.git = git
    self.contact = contact
  end

  # Конструктор через объект класса Student
  def self.init_with_student(student)
    new(student.id, student.get_full_name.slice(11..-1), student.git, student.get_contact)
  end
  
  # Конструктор через строку
  def self.init_with_string(id, string)
  info = self.parse(string)
    contact = nil
    if (info[:phone])
      contact = "Phone: #{info[:phone]}"
    elsif (info[:telegram])
      contact = "Telegram: #{info[:telegram]}"
    elsif (info[:email])
      contact = "Email: #{info[:email]}"
    end
    new(id, info[:full_name], info[:git], contact)
  end
  
  # Парсинг строки на необходимые данные
  def self.parse(string)
    result = {}
  
    string.split(', ').each do |part|
      key_value = part.split(': ')
      key = key_value[0].strip.to_sym 
      value = key_value[1].strip if key_value[1] 
  
      result[key] = value if key && value
    end
  
    result
  end
  
  private
  
  # Сеттер для ФИО
  def full_name=(full_name)
    if (!self.class.valid_full_name?(full_name))
        raise ArgumentError, "Invalid full name format for user with #{self.id}"
    end
    @full_name = full_name
  end

  # Сеттер для гита
  def git=(git)
    if (!Student.valid_git?(git))
        raise ArgumentError, "Invalid git format for user #{self.full_name}"
    end
    @git = git
  end
  
  # Сеттер для контактов
  def contact=(contact)
    if (contact.include?("Phone:") && !Student.valid_phone?(contact.slice(7..-1)))
      raise ArgumentError, "Invalid phone number format for user #{self.full_name}"
    elsif (contact.include?("Telegram:") && !Student.valid_telegram?(contact.slice(10..-1)))
        raise ArgumentError, "Invalid telegram format for user #{self.full_name}"
    elsif (contact.include?("Email:") && !Student.valid_email?(contact.slice(7..-1)))
        raise ArgumentError, "Invalid email format for user #{self.full_name}"
    end
    @contact = contact
  end
  
  # Проверка валидности ФИО
  def self.valid_full_name?(full_name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)?\s[А-ЯЁA-Z]\.[А-ЯЁA-Z]\.$/.match?(full_name)
  end
end
