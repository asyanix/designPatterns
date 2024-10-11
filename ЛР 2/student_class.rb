class Student

  def initialize(id, surname, name, patronymic, phone = '', telegram = '', email = '', git = '')
      @id = id
      @surname = surname
      @name = name
      @patronymic = patronymic
      @phone = phone
      @telegram = telegram
      @email = email
      @git = git
  end

  # геттер и сеттер для id
  def get_id
    @id
  end

  def set_id (value)
    @id = value
  end

  # геттер и сеттер для surname
  def get_surname
    @surname
  end

  def set_surname(value)
    @surname = value
  end
  
  # геттер и сеттер для name
  def get_name
    @name
  end

  def set_name(value)
    @name = value
  end

  # геттер и сеттер для patronymic
  def get_patronymic
    @patronymic
  end

  def set_patronymic(value)
    @patronymic = value
  end

  # геттер и сеттер для phone
  def get_phone
    @phone
  end

  def set_phone(value)
    @phone = value
  end

  # геттер и сеттер для telegram
  def get_telegram
    @telegram
  end

  def set_telegram(value)
    @telegram = value
  end

  # геттер и сеттер для email
  def get_email
    @email
  end

  def set_email(value)
    @email = value
  end

  # геттер и сеттер для git
  def get_git
    @git
  end

  def set_git(value)
    @git = value
  end
  
end

student = Student.new(1, "Cheuzh", "Asya", "Aslanbievna")
puts student.get_name
student.set_name("Anya")
puts student.get_name