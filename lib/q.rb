require 'q/lexer'
require 'q/parser'

module Q
  def _(str)
    return super(str) unless str.is_a?(String)
    lexed = Lexer.execute(str)
    Parser.execute(lexed)
  end
end
