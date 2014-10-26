module Qlang
  module Lexer
    class FormulaLexer < Base
      rule(%r@#{FUNCCV}@) { :FDEF }
      rule(/\=/) { :EQL }

      rule(/[ \t\f]/)

      rule(/\r\n/) { :NLIN }
      rule(/[\w\(].*/) { :FOML }
    end
  end
end
