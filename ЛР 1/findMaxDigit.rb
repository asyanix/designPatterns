# Функция для поиска максимальной цифры, не делящейся на 3, данного числа
def findMaxDigit(number)
	digits = number.chars
	max = 0
	digits.each do |i|
		if (max < i.to_i && i.to_i % 3 != 0)
			max = i.to_i
		end
	end
	return max
end

number = gets
maxDigit = findMaxDigit(number)
if (maxDigit == 0)
	puts "Максимальной цифры числа #{number}, не делящаяся на 3, нет"
else
	puts "Максимальная цифра числа #{number}, не делящаяся на 3, - это #{maxDigit}"
end

