module Q
  module Lexer
    class ContLexer < Base
      rule(/[0-9]+/) { :NUM }
      rule(/\:/) { :CLN }
      rule(/\;/) { :SCLN }
      rule(/\,/) { :CMA }

      rule(/[ \t\f]/)

      rule(/\r\n/) { :NLIN }
      rule(/\w/) { :STR }
    end
  end
end
