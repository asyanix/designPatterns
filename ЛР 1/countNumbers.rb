# Функция для поиска НОД 2 чисел
def gcd(a, b)
  while b != 0
    remainder = a % b
    a = b
    b = remainder
  end
  return a
end

# Функция для подсчета количества четных чисел не взаимно простых с данным
def countEvenNonCoprimeNumbers(number)
	count = 0
	for i in 2...number
		if (gcd(i, number) != 1 && i % 2 == 0)
			count += 1
		end
	end
	return count
end

number = gets.to_i
countNumbers = countEvenNonCoprimeNumbers(number)
puts "Количество четных чисел не взаимно простых с #{number} равно #{countNumbers}"

