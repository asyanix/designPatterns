class User
  attr_accessor :id, :phone, :telegram, :email
  attr_reader :full_name, :git

  def initialize(params = {})
    @id = params[:id]
    self.git = params[:git]
    self.full_name = params[:full_name] if params[:full_name]
    set_contacts(params)
  end

  # Добавление контактов 
  def set_contacts(contacts = {})
    self.phone = contacts[:phone]
    self.telegram = contacts[:telegram]
    self.email = contacts[:email]
  end

  # Сеттер для гита
  def git=(git)
    if (!self.class.valid_git?(git))
      raise ArgumentError, "Invalid git format"
    end
    @git = git
  end

  # Сеттер для ФИО
  def full_name=(full_name)
    raise ArgumentError, "Invalid full name format" unless self.class.valid_full_name?(full_name)
    @full_name = full_name
  end

  # Валидация
  def validate
    self.check_git? && self.check_contact?
  end

  # Проверка наличия гита
  def check_git?
    !self.git.nil? && !self.git.empty?
  end

  # Проверка наличия контакта
  def check_contact?
    !self.phone.nil? || !self.telegram.nil? || !self.email.nil?
  end

  # Получение полного ФИО
  def get_full_name
    if (@full_name)
      @full_name
    else
      "#{self.surname} #{self.name[0]}. #{self.patronymic[0]}."
      end
  end

  # Получение контактной информации
  def get_contact
    if (!self.phone.nil?)
      "Phone: #{self.phone}"
    elsif (!self.telegram.nil?)
      "Telegram: #{self.telegram}"
    elsif (!self.email.nil?)
      "Email: #{self.email}"
    else
      "Contacts are missing!"
    end
  end

  # Получение краткой информации о студенте
  def get_info
    "Full name: #{self.get_full_name}, Git: #{self.git ? self.git : "Git is missing!"}, #{self.get_contact}\n\n"
  end

  protected
  
  # Проверка валидности номера телефона
  def self.valid_phone?(phone)
    phone.nil? || phone.match?(/\A[78]9\d{9}\z/)
  end

  # Проверка валидности тг
  def self.valid_telegram?(telegram)
    telegram.nil? || telegram.match?(/\A[a-zA-Z0-9_]+\z/)
  end

  # Проверка валидности почты
  def self.valid_email?(email)
    email.nil? || email.match?(/\A[a-zA-Z0-9._%+-]+@[a-zA-Z]+\.[a-zA-Z]+\z/)
  end

  # Проверка валидности гита
  def self.valid_git?(git)
    git.nil? || git.match?(/\A[a-zA-Z0-9_]+\z/)
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
end