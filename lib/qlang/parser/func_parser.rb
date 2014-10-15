require 'qlang/lexer/tokens'
module Qlang
  module Parser
    module FuncParser
      include Base
      include Lexer::Tokens
      def execute(string)
        def_func, formula = string.split(/ *= */)
        def_func =~ %r@(#{FUNCV})#{LPRN}#{ANYSP}(#{VARS_BY_CMA})#{ANYSP}#{RPRN}@
        FuncApi.execute($1, $2.split(' *,'), FormulaParser.execute(formula))
      end
      module_function :execute
    end
  end
end
