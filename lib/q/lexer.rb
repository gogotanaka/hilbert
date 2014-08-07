require 'q/lexer/base'
require 'q/lexer/wrap_lexer'

module Q
  module Lexer
    def execute(str)
      WrapLexer.new(str)
    end
    module_function :execute
  end
end
