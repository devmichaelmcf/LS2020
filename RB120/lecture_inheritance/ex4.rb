# What is the method lookup path and how is it important?

# Answer
# -------

# The method lookup path is the locations in a particular order that the Ruby interpreter 
# looks for the existance of a particular method.

# For example, I we called a public instance method on the bulldog1 object from the previous example, then
# Ruby would start by looking in the BullDog class defintion for a method of the same name a dn if found it 
# would execute it, if not found in the class it would look in any modules the class had (starting from last).
# If still not found it would look in the superclass, then their modules. Then back through the inbuilt
# ones such as Object, Kernel, BasicObject. If the method was still not found then RUby would return an error
# since there would be no more places to "look" for the method.

# It is important because there needs to be a predicatable way from us, as humans, to anticipate what method
# implementations are going to be called when we invoke a method on an object. It also allows us to 
# intentionally override methods existing in superclasses to more suitable behaviour.