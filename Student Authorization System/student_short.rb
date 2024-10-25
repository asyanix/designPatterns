require_relative 'student_class.rb'
require_relative 'user.rb'

class Student_short < User
  attr_reader :full_name, :contact
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

  # Проверки наличия контакта
  def has_contacts?
    !self.contact.nil?
  end 

  # Вывод информации о студенте
  def to_s
    result = []
    result << "Id: #{@id}"
    result << "Full name: #{@full_name}"
    result << "Contact: #{@contact}" if @contact
    result << "Git: #{@git}" if @git
    result.compact.join("\n") + "\n\n"
  end
  
  private
  
  # Сеттер для ФИО
  def full_name=(full_name)
    if (!self.class.valid_full_name?(full_name))
        raise ArgumentError, "Invalid full name format for user with id #{self.id}"
    end
    @full_name = full_name
  end
  
  # Сеттер для контактов
  def contact=(contact)
    case contact
    when /^Phone:\s*(.*)$/ then
      if !Student.valid_phone?($1.strip)
        raise ArgumentError, "Invalid phone number format for user #{self.full_name}"
      end
    when /^Telegram:\s*(.*)$/ then
      if !Student.valid_telegram?($1.strip)
        raise ArgumentError, "Invalid telegram format for user #{self.full_name}"
      end
    when /^Email:\s*(.*)$/ then
      if !Student.valid_email?($1.strip)
        raise ArgumentError, "Invalid email format for user #{self.full_name}"
      end
    else
      raise ArgumentError, "Invalid contact type for user #{self.full_name}"
    end
    @contact = contact
  end
  
  # Проверка валидности ФИО
  def self.valid_full_name?(full_name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)? [А-ЯЁA-Z]\. [А-ЯЁA-Z]\.$/.match?(full_name)
  end
end
