class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :git

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
