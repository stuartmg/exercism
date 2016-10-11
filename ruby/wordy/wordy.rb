class WordProblem

  def initialize(question)
    @question = replace_with_operators(question)
  end

  def answer
    stack = @question.split(" ")

    until stack.length == 1 do
      a, op, b = stack.shift(3)

      case
      when op == "+"
        stack.unshift(a.to_i + b.to_i)
      when op == "-"
        stack.unshift(a.to_i - b.to_i)
      when op == "*"
        stack.unshift(a.to_i * b.to_i)
      when op == "/"
        stack.unshift(a.to_i / b.to_i)
      when op == "**"
        stack.unshift(a.to_i ** b.to_i)
      else
        raise ArgumentError, "Unknown operation not permitted"
      end
    end

    stack.first
  end

  private

  def replace_with_operators(question)
    question
      .gsub("What is", "")
      .gsub("?", "")
      .gsub("plus", "+")
      .gsub("minus", "-")
      .gsub("multiplied by", "*")
      .gsub("divided by", "/")
      .gsub("raised to the", "**")
      .gsub("power", "")
      .strip
  end

end
