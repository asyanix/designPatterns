require_relative 'user.rb'
require 'date'
require_relative '../models/tree.rb'

class Student < User
  include Comparable
  attr_reader :surname, :name, :patronymic, :birthdate

  def initialize(params)
    super(params)
    self.surname = params[:surname]
    self.name = params[:name]
    self.patronymic = params[:patronymic]
    self.birthdate = params[:birthdate]
  end

  # Реализация сравнения студентов по дате рождения
  def <=>(other)
    if other.is_a?(Student)
      self.birthdate <=> other.birthdate
    else
      raise ArgumentError, "Can't compare #{self.class} with #{other.class}"
    end
  end

  def ==(other)
    if email.nil? || self.email == other.email
        return false
    end
    if telegram.nil? || self.telegram == other.email
        return false
    end
    if phone.nil? || self.phone == other.phone
        return false
    end
    if git.nil? || self.git == other.git
        return false
    end
    return true
end

  # Получение информации о студенте
  def to_s
    result = ["Id: #{@id}", "Surname: #{@surname}", "Name: #{@name}", "Patronymic: #{@patronymic}"]
    result << "Phone: #{@phone}" if @phone
    result << "Telegram: #{@telegram}" if @telegram
    result << "Email: #{@email}" if @email
    result << "Git: #{@git}" if @git
    result << "Birthdate: #{@birthdate}" if @birthdate
    result.compact.join("\n") + "\n\n"
  end

  def to_h
		{id: self.id, surname: self.surname, name: self.name, patronymic: self.patronymic, birthdate: self.birthdate, telegram: self.telegram, email: self.email, phone: self.phone, git: self.git}
	end

  # Получение фамилию и инициалов
	def initials
		"#{surname} #{name[0]}.#{patronymic[0]}."
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

  # Сеттер для даты рождения
  def birthdate=(birthdate)
    if birthdate.is_a?(Date)
      @birthdate = birthdate
    elsif birthdate.is_a?(String) 
       @birthdate = Date.parse(birthdate)
    else
      raise ArgumentError, "Invalid birthdate"
    end
  end

  def self.new_from_hash(hash)
      self.new(**hash.transform_keys(&:to_sym))
  end
end