# Complete this program so that it produces the expected output:

# Expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  attr_reader :title , :author
  
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")    # @author = "Neil Stephenson"  @title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)      #The author of Snow Crash is Neil Stephenson
puts %(book = #{book}.)      # "book = Snow Crash, by Neil Stephenson"