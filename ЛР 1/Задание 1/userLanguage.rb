userName = ARGV[0]
puts "Welcome, #{userName}"

favoriteLang = STDIN.gets.strip
if favoriteLang == "Ruby"
	puts "Ты - подлиза!"
else 
	puts "Скоро будет ruby"

	if favoriteLang == "C#"
		puts "Игры делаешь?"
	elsif favoriteLang == "Python"
		puts "Не ООП"
	end
end

