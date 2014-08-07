require 'q/lexer'
require 'q/parser'

require 'q/exec'

module Q
  def compile(str)
    return super(str) unless str.is_a?(String)
    lexed = Lexer.execute(str)
    Parser.execute(lexed)
  end
  module_function :compile
end
