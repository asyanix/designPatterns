# Функция для поиска НОД 2 чисел
def gcd(a, b)
  while b != 0
    remainder = a % b
    a = b
    b = remainder
  end
  return a
end

# Функция для поиска наименьшего делителя числа
def smallest_divisor(n)
  return 0 if n <= 1
  
  for i in 2..n do
  	return i if n % i == 0
  end
  return n
end

# Функция для подсчета суммы цифр числа, меньших 5
def sum_digit_less5(number)
	digits = number.to_s.chars
	sum = 0
	digits.each do |i|
		if (i.to_i < 5)
			sum += i.to_i
		end
	end
	return sum
end

# Поиск максимального числа, являющийся не взаимно простым с данным и не делящимся на наименьший делитель исходного числа
def find_max_number(number)
	for i in 2...number
		if (gcd(i, number) != 1 && i % smallest_divisor(number) != 0)
			return i
		end
	end
	return 0
end

number = gets.to_i
max_number = find_max_number(number)
if (max_number == 0)
	puts "Нет такого подходящего числа, являющийся максимальным, не взаимно простым с данным и не делящимся на наименьший делитель исходного числа"
else 
	product = max_number * sum_digit_less5(number)
	puts "Произведение максимального числа, являющийся не взаимно простым с #{number} и не делящимся на наименьший делитель #{number}, и суммы цифр числа, меньших 5, равно #{product}"
end

