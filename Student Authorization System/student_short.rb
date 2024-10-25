require_relative 'student_class.rb'
require_relative 'user.rb'

class Student_short < User
  attr_reader :contact
  private_class_method :new
  
  def initialize(id, full_name, git, contact)
    super(id: id, full_name: full_name, git: git)
    @contact = contact
  end

  # Конструктор через объект класса Student
  def self.init_with_student(student)
    new(student.id, student.get_full_name, student.git, student.get_contact)
  end
  
  # Конструктор через строку
  def self.init_with_string(id, string)
    info = parse(string)
    contact = info[:phone] ? "Phone: #{info[:phone]}" : info[:telegram] ? "Telegram: #{info[:telegram]}" : "Email: #{info[:email]}"
    new(id, info[:full_name], info[:git], contact)
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
