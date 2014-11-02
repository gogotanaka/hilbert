require 'qlang/lexer/base'
require 'qlang/lexer/main_lexer'

module Qlang
  module Lexer
    def execute(str)
      MainLexer.new(str)
    end
    module_function :execute
  end
end
