class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new


# What does each `self` refer to in the above code snippet?

=begin
In the above example the `self` on `line 2` refers to the current class which is `MeMyselfAndI`.

On `line 4` the `def self.me` is the sytax for defining a class method.
On `line 5` the `self` INSIDE the class method refers to the current class which is `MeMyselfAndI`.
On `line 9` the `self` within the instance method definition of `myself` refers to the current instance of the calling object.

The above code shows the differing uses of `self`. Within an instance method it refers the current instance of the calling object.
Outside of and instance method definition but within a class definition it refers to the class.
Outside of the class defintion `self` refers to the `main` object.


=end