require 'hilbert/lexer/base'
require 'hilbert/lexer/main_lexer'

module Hilbert
  module Lexer
    def execute(str)
      MainLexer.new(str)
    end
    module_function :execute
  end
end
