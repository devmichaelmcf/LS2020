# Complete this program so that it produces the expected output:

# Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  attr_accessor :title, :author
  
  def what_title   # added to check if instance variables values exist before setter method invoked. 
    title                 # instance variable value nil before setter methods
  end
  
  def what_author  # added to check if instance variables values exist before setter method invoked. 
    author                # instance variable value nil before setter methods
  end
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
p book.what_title         
p book.what_author
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
p book.what_title
p book.what_author