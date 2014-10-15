module Qlang
  module Lexer
    module Tokens
      # FIRST TOKEN
      NUM = '[0-9]+'
      VAR = '[a-z]'
      FUNCV = '[a-zA-Z]'
      VARNUM = '[0-9a-z]'
      ANYSP = ' *'
      ANYSTR = '.+'
      NONL = '[^\r\n]'
      LPRN = '\('
      RPRN = '\)'
      LBRC = '\{'
      RBRC = '\}'
      CLN = '\:'
      SCLN = ';'
      CMA = '\,'
      SP = ' '

      # SECOND TOKEN
      class ::String
        def line_by(char)
          "#{ANYSP}#{self}(#{ANYSP}#{char}#{ANYSP}#{self})*#{ANYSP}"
        end
      end
      NUMS_BY_CMA = NUM.line_by(CMA)
      VARS_BY_CMA = VAR.line_by(CMA)
      VARNUMS_BY_CMA = VARNUM.line_by(CMA)
      NUMS_BY_SP = NUM.line_by(SP)

      # THIRD TOKEN
      class ::String
        def func_call
          "#{FUNCV}#{LPRN}#{ANYSP}#{self}*#{ANYSP}#{RPRN}"
        end
      end
      FUNCCN =  NUMS_BY_CMA.func_call
      FUNCCV = VARS_BY_CMA.func_call
      FUNCCVN =  VARNUMS_BY_CMA.func_call

      NUMS_BY_SP_BY_SCLN = NUMS_BY_SP.line_by(SCLN)
    end
  end
end
