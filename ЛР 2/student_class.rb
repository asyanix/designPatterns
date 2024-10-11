class Student
  attr_accessor :id, :surname, :name, :patronymic, :phone, :telegram, :email, :git

  def initialize(params)
    @id = params[:id]
    @surname = params[:surname]
    @name = params[:name]
    @patronymic = params[:patronymic]
    @phone = params[:phone] || nil
    @telegram = params[:telegram] || nil
    @email = params[:email] || nil
    @git = params[:git] || nil
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
