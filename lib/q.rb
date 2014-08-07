require 'q/lexer'
require 'q/parser'

module Q
  def _(str)
    lexed = Lexer.execute(str)
    Parser.execute(lexed)
  end
end
