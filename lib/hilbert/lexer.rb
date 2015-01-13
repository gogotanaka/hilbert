require 'hilbert/lexer/base'
require 'hilbert/lexer/main_lexer'
require 'hilbert/lexer/axiom_lexer'

module Hilbert
  module Lexer
    def execute(str)
      if $defing_sys
        AxiomLexer.new(str)
      else
        MainLexer.new(str)
      end
    end
    module_function :execute
  end
end
