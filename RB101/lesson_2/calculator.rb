Kernel.puts("Welcome to the Calculator!")

Kernel.puts("What is your first number: ")
number1 = Kernel.gets().chomp()

Kernel.puts("What is your second number: ")
number2 = Kernel.gets().chomp()

Kernel.puts("What operation do you want to perform? Enter 1) add 2) subtract 3) mutliply 4) division.")
operation = Kernel.gets().chomp()

if operation == "1"
  result = number1.to_i() + number2.to_i()
elsif operation == "2"
  result = number1.to_i() - number2.to_i()
elsif operation == "3"
  result = number1.to_i() * number2.to_i()
else
  result = number1.to_f() / number2.to_f()
end

Kernel.puts("The result is #{result}")

