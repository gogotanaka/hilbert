module Hilbert
  module Lexer
    class WorldLexer < Base
      rule(/#{PROVAR}/) { :PROVAR }
      rule(/#{CONJ}/) { :CONJ }
      rule(/#{DISJ}/) { :DISJ }
      rule(/#{NEGA}/) { :NEGA }
      rule(/#{COND}/) { :COND }
      rule(/#{BICO}/) { :BICO }
      rule(/#{LPRN}/) { :LPRN }
      rule(/#{RPRN}/) { :RPRN }
      rule(/#{SPCS}/) { :SPCS }
    end
  end
end
