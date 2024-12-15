require_relative 'student.rb'
require_relative 'user.rb'

class Student_short < User
  attr_reader :contact
  attr_accessor :full_name
  private_class_method :new
  
  def initialize(id, full_name, git, contact)
    super(id: id, full_name: full_name, git: git)
    self.contact = contact
  end

  # Конструктор через объект класса Student
  def self.init_with_student(student)
    return unless student.is_a?(Student) 
    new(student.id, student.get_full_name, student.git, student.contact)
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

  # Сеттер для контакта
  def contact=(contact)
    if (contact.include?("phone:") && !self.class.valid_phone?(contact.slice(7..-1)))
        raise ArgumentError, "Invalid phone number format"
    elsif (contact.include?("telegram:") && !self.class.valid_telegram?(contact.slice(10..-1)))
        raise ArgumentError, "Invalid telegram format"
    elsif (contact.include?("email:") && !self.class.valid_email?(contact.slice(7..-1)))
        raise ArgumentError, "Invalid email format"
    end
    @contact = contact
  end

  # Проверка валидности ФИО
  def self.valid_full_name?(full_name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)? [А-ЯЁA-Z]\. [А-ЯЁA-Z]\.$/.match?(full_name)
  end
end
