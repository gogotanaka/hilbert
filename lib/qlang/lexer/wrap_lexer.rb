module Qlang
  module Lexer
    class WrapLexer < Base
      rule(%r@#{FUNCTION}#{ANYSP}=#{ANYSP}#{NONL}+@) { :def_func }
      rule(%r@#{FUNCV}\( ?#{NUM}( *, *#{NUM})* *\)@) { :eval_func }
      rule(/S#{ANYSP}\(.+\)\[.+\]/) { :integral }
      rule(/d\/d#{VAR} .*/) { :differential }
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
