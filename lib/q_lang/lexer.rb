require 'q_lang/lexer/base'
require 'q_lang/lexer/wrap_lexer'

module Q
  module Lexer
    def execute(str)
      WrapLexer.new(str)
    end
    module_function :execute
  end
end
