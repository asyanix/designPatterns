class Student

  def initialize(id, surname, name, patronymic, phone = nil, telegram = nil, email = nil, git = nil)
      @id = id
      @surname = surname
      @name = name
      @patronymic = patronymic
      @phone = phone
      @telegram = telegram
      @email = email
      @git = git
  end

  # Геттер и сеттер для id
  def get_id
    @id
  end

  def set_id (value)
    @id = value
  end

  # Геттер и сеттер для surname
  def get_surname
    @surname
  end

  def set_surname(value)
    @surname = value
  end
  
  # Геттер и сеттер для name
  def get_name
    @name
  end

  def set_name(value)
    @name = value
  end

  # Геттер и сеттер для patronymic
  def get_patronymic
    @patronymic
  end

  def set_patronymic(value)
    @patronymic = value
  end

  # Геттер и сеттер для phone
  def get_phone
    @phone
  end

  def set_phone(value)
    @phone = value
  end

  # Геттер и сеттер для telegram
  def get_telegram
    @telegram
  end

  def set_telegram(value)
    @telegram = value
  end

  # Геттер и сеттер для email
  def get_email
    @email
  end

  def set_email(value)
    @email = value
  end

  # Геттер и сеттер для git
  def get_git
    @git
  end

  def set_git(value)
    @git = value
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
    puts "Git : #{@git}" if @github
    puts ""
  end

end
