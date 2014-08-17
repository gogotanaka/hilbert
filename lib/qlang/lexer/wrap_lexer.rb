module Qlang
  module Lexer
    class WrapLexer < Base
      rule(/[fgh]\(\w( ?, ?\w)*\) ?= ?[^\r\n]+/) { :FUNC }
      rule(/[fgh]\( ?\d( *, *\d)* *\)/) { :EFUNC }
      rule(/S *\(.+\)\[.+\]/) { :ITGL }
      rule(/d\/d[a-zA-Z] .*/) { :DIFF }
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
