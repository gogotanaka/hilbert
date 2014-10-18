module Qlang
  module Lexer
    module Tokens
      # NUM
      INT = /[0-9]+/
      FLO = /[0-9]+\.[0-9]+/
      E = /e/
      PI = /pi/
      NUM = /(#{INT}|#{FLO}|#{E}|#{PI})/

      # FUNCTION
      EMBEDDED_FUNC = /(sin|cos|tan|log)/
      USER_FUNC = /[a-zA-Z]/
      FUNCV = /(#{EMBEDDED_FUNC}|#{USER_FUNC})/

      # VARIABLE
      VAR = /([a-d]|[f-z])/
      VAR_MUL2 = /(?!pi)#{VAR}{2}/
      VAR_MUL3 = /(?!#{EMBEDDED_FUNC})#{VAR}{3}/
      # FIX:
      VAR_MUL  = /(?!#{EMBEDDED_FUNC})#{VAR_MUL2}/

      # OPE
      PLS = /\+/
      SUB = /-/
      MUL = /\*/
      DIV = /\//
      EXP = /(\*\*|\^)/
      OPE = /(#{PLS}|#{SUB}|#{MUL}|#{DIV}|#{EXP})/

      VARNUM = /(#{NUM}|#{VAR})/
      ANYSP = ' *'
      ANYSTR = /.+/
      NONL = /[^\r\n]/
      LPRN = /\(/
      RPRN = /\)/
      LBRC = /\{/
      RBRC = /\}/
      CLN = /\:/
      SCLN = /;/
      CMA = /\,/
      SP = / /

      # SECOND TOKEN
      class Tmp
        def self.string_out(str, partition)
        /#{ANYSP}#{str}(#{ANYSP}#{partition}#{ANYSP}#{str})*#{ANYSP}/
        end

        def self.func_call(args)
          /#{FUNCV}#{LPRN}#{ANYSP}#{args}#{ANYSP}#{RPRN}/
        end
      end


      NUMS_BY_CMA = Tmp.string_out(NUM, CMA)
      VARS_BY_CMA = Tmp.string_out(VAR, CMA)
      VARNUMS_BY_CMA = Tmp.string_out(VARNUM, CMA)
      NUMS_BY_SP = Tmp.string_out(NUM, SP)

      # THIRD TOKEN
      FUNCCN =  Tmp.func_call(NUMS_BY_CMA)
      FUNCCV = Tmp.func_call(VARS_BY_CMA)
      FUNCCVN =  Tmp.func_call(VARNUMS_BY_CMA)

      NUMS_BY_SP_BY_SCLN = Tmp.string_out(NUMS_BY_SP, SCLN)


      FORMULA = "(#{VARNUM}|#{LPRN}|#{RPRN}| )+"
    end
  end
end
