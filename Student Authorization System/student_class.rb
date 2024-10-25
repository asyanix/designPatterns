require_relative 'user.rb'

class Student < User
  attr_reader :surname, :name, :patronymic,  :phone, :telegram, :email

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

  # Получение краткой информации о студенте
  def get_info
    "#{self.get_full_name}, Git: #{self.git ? self.git : "Git is missing!"}, #{self.get_contact}\n\n"
  end

  # Проверка валидности ФИО
  def self.valid_full_name?(name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)?$/.match?(name)  
  end

  # Проверки наличия хотя бы 1 контакта
  def check_contact?
    !self.phone.nil? || !self.telegram.nil? || !self.email.nil?
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