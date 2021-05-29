# Behold this incomplete class for constructing boxed banners.

# Notes on solution:
# I DID NOT have to include if-condition as " " * 0 is ""
class Banner

  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :message
  
  def horizontal_rule
    if message.length == 0
      "+--+"
    else
      "+-" + ("-" * message.length) + "-+"
    end
  end

  def empty_line
    if message.length == 0
      "|  |"
    else
      "| " + (" " * message.length) + " |"
    end
  end

  def message_line
    if message.length == 0
      "|  |"
    else
      "| #{@message} |"
    end
  end
end

banner1 = Banner.new('')
puts banner1

# USEFUL assistance to think about topic:
# +--+ #horizontal rule
# |  |#empty line
# |  |#message line
# |  |#empty line
# +--+#horizontal rule

banner2 = Banner.new('To boldly go where no one has gone before.')
puts banner2