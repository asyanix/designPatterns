class Student
  attr_accessor :id
  attr_reader :surname, :name, :patronymic, :git, :phone, :telegram, :email, :email

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

  # Вывод краткой информации о студенте
  def get_info
    "#{self.get_full_name}, Git: #{self.git ? self.git : "Git is missing!"}, #{self.get_contact}"
  end

  # Вывод полного ФИО
  def get_full_name
    "full name: #{self.surname} #{self.name[0]}.#{self.patronymic[0]}."
  end

  # Вывод контактной информации
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

  # Проверка валидности ФИО
  def self.valid_full_name?(name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)?$/.match?(name)  
  end

  # Проверка наличия гита
  def check_git?
    !@git.nil? && !@git.empty?
  end

  # Проверки наличия хотя бы 1 контакта
  def check_contact?
    !@phone.nil? || !@telegram.nil? || !@email.nil?
  end

  # Добавление контактов для студента
  def set_contacts(contacts)
    if (!self.class.valid_phone?(contacts[:phone]))
        raise ArgumentError, "Invalid phone number format"
    end
    @phone = contacts[:phone] if contacts.key?(:phone)

    if (!self.class.valid_telegram?(contacts[:telegram]))
        raise ArgumentError, "Invalid telegram format"
    end
    @telegram = contacts[:telegram] if contacts.key?(:telegram)

    if (!self.class.valid_email?(contacts[:email]))
        raise ArgumentError, "Invalid email format"
    end
    @email = contacts[:email] if contacts.key?(:email)
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

  private 

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

  # Сеттер для имени
  def name=(name)
    if (!self.class.valid_full_name?(name))
        raise ArgumentError, "Invalid name format - for user with id #{self.id}"
    end
    @name = name
  end

  # Сеттер для фамилии
  def surname=(surname)
      if (!self.class.valid_full_name?(surname))
          raise ArgumentError, "Invalid surname format - for user with id #{self.id}"
      end
      @surname = surname
  end

  # Сеттер для отчества
  def patronymic=(patronymic)
      if (!self.class.valid_full_name?(patronymic))
          raise ArgumentError, "Invalid patronymic format - for user with id #{self.id}"
      end
      @patronymic = patronymic
  end


end
