# Create a class 'Student' with attributes name and grade. 
# Do NOT make the grade getter public, so joe.grade will raise an error. 
# Create a better_grade_than? method, that you can call like so...

# EXPECTED OUTPUT BELOW!

# puts "Well done!" if joe.better_grade_than?(bob)

class Student
  attr_accessor :name
  
  def initialize(name, grade)
    @name  = name
    @grade = grade
  end
  
  def better_grade_than?(other)
    if self.grade > other.grade
      "You had the better grade with #{self.grade} compared to other of #{other.grade}."
    else
      "You have a worse grade with a lowly #{self.grade} compared to #{other.grade}."
    end
  end
  
  protected
  
  attr_reader :grade
end

paul = Student.new("Paul", 99)
michael = Student.new("Michael", 89)
jim = Student.new("Jim", 14)

p paul.better_grade_than?(michael)
p jim.better_grade_than?(michael)