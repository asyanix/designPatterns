class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :git

  # Сеттер для номера телефона
  def phone=(value)
    if value.nil? || Student.valid_phone?(value)
      @phone = value
    else
      raise ArgumentError, "Invalid phone number: #{value} - for user #{self.surname} #{self.name} #{self.patronymic}"
    end
  end

  def initialize(params)
    @id = params[:id]
    @surname = params[:surname]
    @name = params[:name]
    @patronymic = params[:patronymic]
    self.phone = params[:phone]
    @telegram = params[:telegram] || nil
    @email = params[:email] || nil
    @git = params[:git] || nil
  end

  # Проверки валидности номера телефона
  def self.valid_phone?(phone)
    phone.match?(/\A[78]9\d{9}\z/)
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
