module Qlang
  module Lexer
    class FormulaLexer < Base
      rule(/\^/) { :EXP }
      rule(/#{EMBEDDED_FUNC}/) { :BFUNC }
      rule(/(pi|[1-9a-z]){2,}/) { :MUL }
      rule(/(pi|[1-9a-z])/) { :SNGL }
      rule(/([^\^1-9a-z]|^pi)+/) { :OTHER }




      # rule(/#{OPE}/) { :OPE }
      # rule(/#{FUNCV}/) { :FUNCV }
      # rule(/#{VAR}/) { :VAR }
      # rule(/#{NUM}/) { :NUM }
      # rule(/#{LPRN}/) { :LPRN }
      # rule(/#{RPRN}/) { :RPRN }

      # rule(/#{ANYSP}/) {  }
    end
  end
end
