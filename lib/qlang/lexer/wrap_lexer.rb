require 'pry'
module Qlang
  module Lexer
    class WrapLexer < Base
      rule(%r@#{FUNCCV}#{ANYSP}=#{ANYSP}#{NONL}+@) { :def_func }
      rule(%r@#{FUNCCN}@) { :eval_func }
      rule(/S#{ANYSP}#{LPRN}#{ANYSTR}#{RPRN}\[#{ANYSTR}\]/) { :integral }
      rule(/d\/d#{VAR} .*/) { :differential }
      rule(%r@#{LPRN}#{NUMS_BY_SP_BY_SCLN}#{RPRN}@) { :matrix }


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
