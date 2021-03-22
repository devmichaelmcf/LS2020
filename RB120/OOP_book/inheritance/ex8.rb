# Given the following code...


# bob = Person.new
# bob.hi


# And the corresponding error message.....


# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'


# What is the problem and how would you go about fixing it?


# ANSWER:
# The problem is we are trying to call a private instance method #hi from outside the class.
# To fix this error I would change either the #hi private method TO a public method.
# Or (if I wanted to keep #hi private) I would create a second method that WAS public but used the private method
# #hi in its implementation. Then I could stil use its functionality but still preserve it as a private method.