module Qlang
  module Lexer
    class WrapLexer < Base
      rule(/(#{FUNCCV})#{ANYSP}#{EQL}#{ANYSP}(#{FORMULA})/) { :def_func }
      rule(/#{ITGRLSYM}#{ANYSP}#{LPRN}(#{ANYSTR})#{RPRN}#{LBRCT}(#{ANYSTR})#{RBRCT}/) { :integral }
      rule(/d\/d(#{VAR}) (#{FORMULA})/) { :differential }
      rule(/#{LPRN}(#{NUMS_BY_SP})#{RPRN}/) { :vector }
      rule(/#{LPRN}(#{NUMS_BY_SP_BY_SCLN_OR_NELN})#{RPRN}t/m) { :tmatrix }
      rule(/#{LPRN}(#{NUMS_BY_SP_BY_SCLN_OR_NELN})#{RPRN}/m) { :matrix }

      rule(/#{FUNCCN}/) { :FUNCCN }

      rule(/#{LPRN}/) { :LPRN }
      rule(/#{RPRN}/) { :RPRN }
      rule(/#{LBRCS}/) { :LBRCS }
      rule(/#{RBRCS}/) { :RBRCS }

      rule(/[ \t\f]/)

      rule(/(\r|\n)+/) { :NULL }

      rule(/[^\(\)\{\}(\n\n)]+/) { :CONT }
    end
  end
end
