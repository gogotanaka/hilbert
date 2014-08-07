module Q
  module Lexer
    class ContLexer < Base
      rule(/\%R\%\|\|\|.+\|\|\|/) { :R }
      rule(/('|")\w+('|")/) { :STR }
      rule(/[0-9]+/) { :NUM }
      rule(/\:/) { :CLN }
      rule(/\;/) { :SCLN }
      rule(/\,/) { :CMA }

      rule(/[ \t\f]/)

      rule(/\r\n/) { :NLIN }
      rule(/\w+/) { :OTHER }
    end
  end
end
