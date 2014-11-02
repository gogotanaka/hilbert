require 'qlang/lexer/tokens'
module Qlang
  module Parser
    module FuncParser
      include Base
      include Lexer::Tokens
      def execute(els)
        def_func, formula = els[0], els[1]
        def_func =~ /(#{USER_FUNC})#{LPRN}#{ANYSP}(#{VARS_BY_CMA})#{ANYSP}#{RPRN}/
        FuncApi.execute($1, $2.split(' *,'), FormulaParser.execute(formula))
      end
      module_function :execute
    end
  end
end
