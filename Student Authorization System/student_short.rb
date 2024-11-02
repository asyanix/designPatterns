require_relative 'student_class.rb'
require_relative 'user.rb'

class Student_short < User
  attr_reader :contact
  private_class_method :new
  
  def initialize(id, full_name, git, contact)
    super(id: id, full_name: full_name, git: git)
    
    if contact.start_with?("Phone: ")
      phone = contact.sub("Phone: ", "")
      raise ArgumentError, "Invalid phone format" unless self.class.valid_phone?(phone)
    elsif contact.start_with?("Telegram: ")
      telegram = contact.sub("Telegram: ", "")
      raise ArgumentError, "Invalid telegram format" unless self.class.valid_telegram?(telegram)
    elsif contact.start_with?("Email: ")
      email = contact.sub("Email: ", "")
      raise ArgumentError, "Invalid email format" unless self.class.valid_email?(email)
    else
      raise ArgumentError, "Unknown contact type"
    end
    @contact = contact
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

  # Проверка валидности ФИО
  def self.valid_full_name?(full_name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)? [А-ЯЁA-Z]\. [А-ЯЁA-Z]\.$/.match?(full_name)
  end
end
