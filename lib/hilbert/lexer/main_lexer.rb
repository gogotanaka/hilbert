module Hilbert
  module Lexer
    class MainLexer < Base
      # TODO: So far so good, but...

      rule(/(#{FUNCCV})#{ANYSP}#{EQL}#{ANYSP}(#{FORMULA})/) { :DEF_FUNC }
      rule(/#{INTE_SYM}#{ANYSP}#{LPRN}(#{ANYSTR})#{RPRN}#{LBRCT}(#{ANYSTR})#{RBRCT}/) { :INTEGRAL }
      rule(/#{DIFF_SYM}(#{VAR}) (#{FORMULA})/) { :DIFFERENTIAL }
      rule(/#{LIM_SYM}#{LBRCT}(#{VAR})#{RSARW}(#{VARNUM})#{RBRCT} (#{FORMULA})/) { :LIMIT }
      rule(/#{SGM_SYM}#{LBRCT}(#{VAR})#{EQL}(#{INT})#{CMA}#{ANYSP}(#{INT})#{RBRCT} (#{FORMULA})/) { :SIGMA }

      rule(/#{LPRN}(#{NUMS_BY_SP})#{RPRN}/) { :VECTOR }
      rule(/#{LPRN}(#{NUMS_BY_SP_BY_SCLN_OR_NELN})#{RPRN}t/m) { :TMATRIX }
      rule(/#{LPRN}(#{NUMS_BY_SP_BY_SCLN_OR_NELN})#{RPRN}/m) { :MATRIX }

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
