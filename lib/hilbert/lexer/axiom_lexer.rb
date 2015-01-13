module Hilbert
  module Lexer
    class AxiomLexer < Base
      rule(/def +(.+)/) { :DEF_PROP }
      rule(/end/) { :END }
      rule(/#{SPC}/)
      rule(/(\r|\n)+/)
      rule(/.+/) { :UNKNOW }
    end
  end
end
