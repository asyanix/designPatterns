class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :git

  # Сеттер для номера телефона
  def phone=(value)
    if Student.valid_phone?(value)
      @phone = value
    else
      raise ArgumentError, "Invalid phone number: #{value} - for user #{self.surname} #{self.name} #{self.patronymic}"
    end
  end

  # Сеттер для тг
  def telegram=(value)
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
  def email=(value)
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
    self.phone = params[:phone]
    self.telegram = params[:telegram]
    self.email = params[:email]
    self.git = params[:git]
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

  # Вывод информации о студенте
  def show_info()
    puts "Id: #{@id}"
    puts "Surname: #{@surname}"
    puts "Name: #{@name}"
    puts "Patronymic: #{@patronymic}"
    puts "Phone: #{@phone}" if @phone
    puts "Telegram: #{@telegram}" if @telegram
    puts "Email: #{@email}" if @email
    puts "Git : #{@git}" if @git
    puts ""
  end

end
