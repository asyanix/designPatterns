require_relative 'user.rb'

class Student < User
  attr_reader :surname, :name, :patronymic

  def initialize(params)
    super(params)
    self.surname = params[:surname]
    self.name = params[:name]
    self.patronymic = params[:patronymic]
  end

  # Получение информации о студенте
  def to_s
    result = ["Id: #{@id}", "Surname: #{@surname}", "Name: #{@name}", "Patronymic: #{@patronymic}"]
    result << "Phone: #{@phone}" if @phone
    result << "Telegram: #{@telegram}" if @telegram
    result << "Email: #{@email}" if @email
    result << "Git: #{@git}" if @git
    result.compact.join("\n") + "\n\n"
  end

  # Проверка валидности ФИО
  def self.valid_full_name?(name)
    /^[А-ЯЁA-Z][а-яёa-z]+(-[А-ЯЁA-Z][а-яёa-z]+)?$/.match?(name)  
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