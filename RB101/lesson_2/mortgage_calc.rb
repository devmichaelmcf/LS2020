loop do
  Kernel.puts("Hello! Welcome to the mortgage calculator!")
  
  Kernel.puts("Please enter your loan amount in pounds?")
  
  def is_valid_num?(num_string)
    num_string.to_i.to_s == num_string || num_string.to_f.to_s == num_string
  end
  
  loan_amount = ''
  loop do
    loan_amount = Kernel.gets().chomp
    break if is_valid_num?(loan_amount)
    Kernel.puts("This isn't a valid number! Try again!")
  end
  
  Kernel.puts("Your requested loan amount is #{loan_amount} pounds.")
  
  Kernel.puts("What is the Annual Percentage Rate (APR)?")
  
  apr_strnum = ''
  loop do
    apr_strnum = Kernel.gets().chomp()
    break if is_valid_num?(apr_strnum)
    Kernel.puts("This isn't a valid number! Try again!")
  end
    
  Kernel.puts("What is the loan duration of the loan in years and months? We will ask for years and months separately.")
  Kernel.puts("What is the loan in full years (no decimels)? Month entry be asked later.")
  
  year_strnum =''
  loop do
    year_strnum = Kernel.gets().chomp()
    break if year_strnum.to_i.to_s == year_strnum
    Kernel.puts("This isn't a valid number! Try again! Years only remember. Must be greater than one year.")
  end
  
  Kernel.puts("What is the loan in full MONTHS (no decimels)?")
  
  month_strnum = ''
  loop do
    month_strnum = Kernel.gets().chomp()
    break if month_strnum.to_i.to_s == month_strnum
    Kernel.puts("This isn't a valid number! Try again! MONTHS only remember.")
  end
  
  loan_duration_months = (year_strnum.to_i * 12) + month_strnum.to_i
  Kernel.puts("The loan duration is #{year_strnum} years and #{month_strnum} months.")
  Kernel.puts("This duration is #{loan_duration_months} months in total.")
  
  monthly_apr = (apr_strnum.to_f / 12.0)
  
  Kernel.puts("Your APR is #{apr_strnum} which evaluates to a monthly interest of #{monthly_apr.floor(2)}.")
  monthly_apr_as_dec = monthly_apr / 100
  Kernel.puts(monthly_apr_as_dec)   #THIS IS MONTHLY INTEREST WE USE IN EQUATION
  
  Kernel.puts("Given these details the  your monthly payment is: ")
  Kernel.puts("Loading...........")
  
  
  monthly_payment = loan_amount.to_f * (monthly_apr_as_dec / (1 - (1 + monthly_apr_as_dec)**(-loan_duration_months)))
  Kernel.puts("The monthly_payment is #{monthly_payment.floor(2)} for #{loan_duration_months} months.")
  total_amount_paid = monthly_payment * loan_duration_months
  Kernel.puts("The total amount payed over the loan is #{total_amount_paid} pounds over #{loan_duration_months} months")
  total_interest_paid = total_amount_paid - (loan_amount.to_i)
  Kernel.puts("Total interest is : #{total_interest_paid}")
  
  Kernel.puts("Do you wish to calculate another mortgage payment? Please enter Y to repeat. Any key to exit.")
  answer = Kernel.gets()
  break if answer.start_with?("y") || answer.start_with?("Y")
end

Kernel.puts("Thank you for using Michael's Marvelous Mortgage Calculator! Goodbye!")