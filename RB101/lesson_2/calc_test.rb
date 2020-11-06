require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'es'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)   # make sure the "messages" method is declared above this line
  Kernel.puts("=> #{message}")
end

# now you can just do:


puts MESSAGES.inspect
def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_method(op)
  case op
    when "1"
      "Adding"
    when "2"
      "Subtracting"
    when "3"
      "Multiplying"
    when "4"
      "Dividing"
  end
end

name = ''
prompt(messages('welcome', LANGUAGE))
#prompt("Welcome to the Calculator! Enter your name: ")

loop do
  name = Kernel.gets().chomp()

  if name.empty?
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end

prompt("Hi #{name}!")

loop do
  number1 = ''
  loop do
    prompt("What is your first number: ")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("Hmmm.. that doesn't look like a valid number.")
    end
  end

  number2 = ''
  loop do
    prompt("What is your second number: ")
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt("Hmm.. that doesn't look like a valid number.")
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
MSG

  prompt(operator_prompt)
  operation = ''
  loop do
    operation = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operation)
      break
    else
      prompt("Not a valid operator. 1, 2, 3 or 4")
    end
  end

  prompt("#{operation_to_method(operation)} the two numbers...")

  result = case operation
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}")

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = Kernel.gets()
  break unless answer.downcase.start_with?("y")
end

prompt('Thank you for using the calculator. Goodbye!')
