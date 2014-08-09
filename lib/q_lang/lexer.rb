require 'q_lang/lexer/base'
require 'q_lang/lexer/wrap_lexer'

module QLang
  module Lexer
    def execute(str)
      WrapLexer.new(str)
    end
    module_function :execute
  end
end
