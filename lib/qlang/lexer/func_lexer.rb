module Qlang
  module Lexer
    class FuncLexer < Base
      rule(/\w\(\w( ?, ?\w)*\)/) { :FDEF }
      rule(/\=/) { :EQL }

      rule(/[ \t\f]/)

      rule(/\r\n/) { :NLIN }
      rule(/[\w\(].*/) { :FOML }
    end
  end
end
