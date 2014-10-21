module Qlang
  module Lexer
    class WrapLexer < Base
      rule(/#{FUNCCV}#{ANYSP}#{EQL}#{ANYSP}#{FORMULA}/) { :def_func }
      rule(/#{FUNCCN}/) { :eval_func }
      rule(/S#{ANYSP}#{LPRN}#{ANYSTR}#{RPRN}\[#{ANYSTR}\]/) { :integral }
      rule(/d\/d#{VAR} #{FORMULA}/) { :differential }
      rule(/#{LPRN}#{NUMS_BY_SP}#{RPRN}/) { :vector }
      rule(/#{LPRN}#{NUMS_BY_SP_BY_SCLN}#{RPRN}t/) { :tmatrix }
      rule(/#{LPRN}#{NUMS_BY_SP_BY_SCLN}#{RPRN}/) { :matrix }


      rule(/#{LPRN}/) { :LPRN }
      rule(/#{RPRN}/) { :RPRN }
      rule(/#{LBRCS}/) { :LBRCS }
      rule(/#{RBRCS}/) { :RBRCS }

      rule(/[ \t\f]/)

      rule(/(\r|\n)+/) { :NLIN }

      rule(/[^\(\)\{\}(\n\n)]+/) { :CONT }
    end
  end
end
