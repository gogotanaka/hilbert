module QLang
  module Lexer
    class WrapLexer < Base
      rule(/\w\(\w, ?\w\) ?= ?[^\r\n]+/)  { :FUNC }
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
