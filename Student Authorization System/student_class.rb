class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :git

  # Сеттер для номера телефона
  private def phone=(value)
    if Student.valid_phone?(value)
      @phone = value
    else
      raise ArgumentError, "Invalid phone number: #{value} - for user #{self.surname} #{self.name} #{self.patronymic}"
    end
  end

  # Сеттер для тг
  private def telegram=(value)
    if Student.valid_telegram?(value)
      @telegram = value
    else
      raise ArgumentError, "Invalid telegram username: #{value} - for user #{self.surname} #{self.name} #{self.patronymic}"
    end
  end

  # Сеттер для гита
  def git=(value)
    if Student.valid_git?(value)
      @git = value
    else
      raise ArgumentError, "Invalid GitHub username: #{value} - for user #{self.surname} #{self.name} #{self.patronymic}"
    end
  end

  # Сеттер для почты
  private def email=(value)
    if Student.valid_email?(value)
      @email = value
    else
      raise ArgumentError, "Invalid email: #{value} - for user #{self.surname} #{self.name} #{self.patronymic}"
    end
  end

  def initialize(params)
    @id = params[:id]
    @surname = params[:surname]
    @name = params[:name]
    @patronymic = params[:patronymic]
    self.git = params[:git]
    self.set_contacts({
            phone:params[:phone],
            telegram:params[:telegram],
            email:params[:email]
         })
  end

  # Проверка валидности номера телефона
  def self.valid_phone?(phone)
    phone.nil? || phone.match?(/\A[78]9\d{9}\z/)
  end

  # Проверка валидности тг
  def self.valid_telegram?(telegram)
    telegram.nil? || telegram.match?(/\A[a-zA-Z0-9_]+\z/)
  end
  
  # Проверка валидности гита
  def self.valid_git?(git)
    git.nil? || git.match?(/\A[a-zA-Z0-9_]+\z/)
  end
  
  # Проверка валидности почты
  def self.valid_email?(email)
    email.nil? || email.match?(/\A[a-zA-Z0-9._%+-]+@[a-zA-Z]+\.[a-zA-Z]+\z/)
  end

  # Проверка наличия гита
  def check_git?
    !@git.nil? && !@git.empty?
  end

  # Проверки наличия хотя бы 1 контакта
  def check_contact?
    !@phone.nil? || !@telegram.nil? || !@email.nil?
  end

  # Метод валидации
  def validate
    unless check_git?
      raise ArgumentError, "Git username for user #{self.surname} #{self.name} #{self.patronymic} is missing!"
    end

    unless check_contact?
      raise ArgumentError, "No contact information for user #{self.surname} #{self.name} #{self.patronymic} provided!"
    end
  end

  # Добавление контактов для студента
  def set_contacts(contacts)
    self.phone = contacts[:phone]
    self.telegram = contacts[:telegram]
    self.email = contacts[:email]
  end

  # Вывод информации о студенте
  def to_s
    result = []
    result << "Id: #{@id}"
    result << "Surname: #{@surname}"
    result << "Name: #{@name}"
    result << "Patronymic: #{@patronymic}"
    result << "Phone: #{@phone}" if @phone
    result << "Telegram: #{@telegram}" if @telegram
    result << "Email: #{@email}" if @email
    result << "Git: #{@git}" if @git
    result.compact.join("\n") + "\n\n"
  end

end
