module Q
  module Lexer
    class WrapLexer < Base
      rule(/\(/) { :LPRN }
      rule(/\)/) { :RPRN }
      rule(/\{/) { :LBRC }
      rule(/\}/) { :RBRC }

      rule(/[ \t\f]/)

      rule(/[^\(\)\{\}]+/) { :CONT }
    end
  end
end
