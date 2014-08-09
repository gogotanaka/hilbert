require 'qlang/lexer/base'
require 'qlang/lexer/wrap_lexer'

module Qlang
  module Lexer
    def execute(str)
      WrapLexer.new(str)
    end
    module_function :execute
  end
end
