module Qlang
  module Lexer
    module Tokens
      # FIRST TOKEN
      INT = /[0-9]+/
      FLO = /[0-9]+\.[0-9]+/
      NUM = "(#{INT}|#{FLO})"
      VAR = '[a-z]'
      FUNCV = '[a-zA-Z]'
      VARNUM = "(#{NUM}|#{VAR})"
      ANYSP = ' *'
      ANYSTR = '.+'
      NONL = '[^\r\n]'
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


      # FORM
      PLS = '\+'
      SUB = '-'
      MUL = '\*'
      DIV = '\/'
      EXP = '(\*\*|\^)'

      FORMULA = "(#{PLS}|#{SUB}|#{MUL}|#{DIV}|#{EXP}|#{VARNUM}|#{LPRN}|#{RPRN}| )+"
    end
  end
end
