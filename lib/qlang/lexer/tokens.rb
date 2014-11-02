module Qlang
  module Lexer
    module Tokens
      # NUM
      INT = /[0-9]+/
      FLO = /[0-9]+\.[0-9]+/
      E = /e/
      PI = /pi/
      INF = /oo/
      NUM = /(?:#{FLO}|#{INT}|#{E}|#{PI}|#{INF})/

      # FUNCTION
      LPRN = /\(/
      RPRN = /\)/
      EMBEDDED_FUNC = /(?:sin|cos|tan|log)/
      USER_FUNC = /[a-zA-Z]/
      # h(x + y) != h * (x + y)
      FUNCV = /(?:#{EMBEDDED_FUNC}|#{USER_FUNC})(?=#{LPRN})/

      # VARIABLE
      VAR = /(?:[a-d]|[f-z])/
      # VAR_MUL2 = /(?!pi)#{VAR}{2}/
      # #VAR_MUL3 = /(?!#{EMBEDDED_FUNC})#{VAR}{3}/
      # # FIX:
      # VAR_MUL  = /(?!#{EMBEDDED_FUNC})#{VAR_MUL2}/

      # # TERM
      # TERM = /(#{NUM}|#{VAR_MUL}|#{VAR_MUL})/

      # OPE
      PLS = /\+/
      SUB = /-/
      MUL = /\*/
      DIV = /\//
      EXP = /(\*\*|\^)/
      OPE = /(?:#{PLS}|#{SUB}|#{MUL}|#{DIV}|#{EXP})/

      VARNUM = /(?:#{NUM}|#{VAR})/
      ANYSP = ' *'
      ANYSTR = /.+/
      NONL = /[^\r\n]/

      PRN = /(?:#{LPRN}|#{RPRN})/

      LBRCS = /\{/
      RBRCS = /\}/
      BRCS = /(?:#{LBRCS}|#{RBRCS})/

      LBRCT = /\[/
      RBRCT = /\]/
      BRCT = /(?:#{LBRCT}|#{RBRCT})/

      CLN = /\:/
      SCLN = /;/
      CMA = /\,/
      EQL = /\=/

      RSARW = '->'
      LSARW = '<-'
      RDARW = '=>'
      LDARW = '<='
      SP = / /
      NLIN = /(\r|\n)/

      ITGRLSYM = 'S'
      # FIXIT
      SCLN_OR_NELN = /(?:#{SCLN}|#{NLIN})/

      # TODO: what is better
      class Util
        def self.string_out(str, partition)
          /#{ANYSP}#{str}(?:#{ANYSP}#{partition}#{ANYSP}#{str})*#{ANYSP}/
        end

        def self.func_call(args)
          /#{FUNCV}#{LPRN}#{ANYSP}#{args}#{ANYSP}#{RPRN}/
        end
      end

      NUMS_BY_CMA = Util.string_out(NUM, CMA)
      VARS_BY_CMA = Util.string_out(VAR, CMA)
      VARNUMS_BY_CMA = Util.string_out(VARNUM, CMA)
      NUMS_BY_SP = Util.string_out(NUM, SP)

      FUNCCN =  Util.func_call(NUMS_BY_CMA)
      FUNCCV = Util.func_call(VARS_BY_CMA)
      FUNCCVN =  Util.func_call(VARNUMS_BY_CMA)

      NUMS_BY_SP_BY_SCLN_OR_NELN = Util.string_out(NUMS_BY_SP, SCLN_OR_NELN)

      FORMULA = /(?:#{OPE}|#{FUNCV}|#{VAR}|#{NUM}|#{PRN}|#{ANYSP})+/
    end
  end
end
