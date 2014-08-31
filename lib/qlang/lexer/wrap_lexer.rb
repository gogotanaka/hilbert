module Qlang
  module Lexer
    class WrapLexer < Base
      rule(/#{FUNCN}\(#{VARNUM}( *, *#{VARNUM})*\) ?= ?[^\r\n]+/) { :def_func }
      rule(/#{FUNCN}\( ?#{NUM}( *, *#{NUM})* *\)/) { :eval_func }
      rule(/S *\(.+\)\[.+\]/) { :ITGL }
      rule(/d\/d#{VAR} .*/) { :DIFF }
      rule(/\(/) { :LPRN }
      rule(/\)/) { :RPRN }
      rule(/\{/) { :LBRC }
      rule(/\}/) { :RBRC }

      rule(/[ \t\f]/)

      rule(/(\r|\n)+/) { :NLIN }

      rule(/[^\(\)\{\}(\n\n)]+/) { :CONT }
    end
  end
end
