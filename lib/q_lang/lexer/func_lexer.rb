module QLang
  module Lexer
    class FuncLexer < Base
      rule(/\w\(\w( ?, ?\w)*\)/) { :FDEF }
      rule(/\=/) { :EQL }

      rule(/[ \t\f]/)

      rule(/\r\n/) { :NLIN }
      rule(/\w.*/) { :OTHER }
    end
  end
end
