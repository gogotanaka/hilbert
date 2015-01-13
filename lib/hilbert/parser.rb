require 'hilbert/api'

require 'hilbert/parser/base'
require 'hilbert/parser/matrix_parser'
require 'hilbert/parser/vector_parser'
require 'hilbert/parser/list_parser'
require 'hilbert/parser/func_parser'
require 'hilbert/parser/integral_parser'
require 'hilbert/parser/limit_parser'
require 'hilbert/parser/sigma_parser'
require 'hilbert/parser/world_parser'

require 'hilbert/parser/formula_parser'
require 'hilbert/lexer/world_lexer'
require 'hilbert/world/axiom_system'
require 'pry'
module Hilbert
  module Parser
    include Lexer::Tokens
    SYM = '\w+'

    ONEHASH = "#{ANYSP}#{SYM}#{CLN}#{ANYSP}#{VARNUM}#{ANYSP}" # sdf: 234
    def execute(lexed)
      time = Time.now
      until lexed.token_str =~ /\A:(NLIN|R)\d+\z/

if Time.now > time + 10
fail <<-ERROR
I'm so sorry, something wrong. Please feel free to report this. [DEBUG CODE:29]

========== DEBUG INFO ==========
lexed.token_str: #{lexed.token_str}
$defning_sym:    #{$defning_sym}
ERROR
end
        case lexed.token_str
        when /:(DEF_AXIOM)(\d+)/
          token_els = lexed.get_els($2)
          $defing_sys = Object.const_set(token_els.first, Class.new(World::AxiomSystem))
          lexed.parsed!('', $2)
        when /:(POST_ZFC)(\d+)/
          Hilbert::Lexer::MainLexer.zfc_analysis!
          lexed.parsed!('"success! :)"', $2)
        when /:(P_PARAD)(\d+)/
          lexed.parsed!($world.paradox?, $2)

        when /:(DEFLOGIC)(\d+)/
          value = lexed.get_value($1).delete("\n")
          rslt = $world << value
          lexed.parsed!(rslt, $2)

        when /:(EVALOGIC)(\d+)/
          value = lexed.get_value($1).rm(/ *\?/).delete("\n")
          rslt = $world.impl value
          lexed.parsed!(rslt, $2)

        when /:(VECTOR)(\d+)/, /:(MATRIX)(\d+)/, /:(TMATRIX)(\d+)/, /:(INTEGRAL)(\d+)/, /:(DEF_FUNC)(\d+)/, /:(DIFFERENTIAL)(\d+)/, /:(LIMIT)(\d+)/, /:(SIGMA)(\d+)/
          token_els = lexed.get_els($2)

          parsed = case $1
                   when 'VECTOR'   then VectorParser.execute(token_els)
                   when 'MATRIX'   then MatrixParser.execute(token_els)
                   when 'TMATRIX'  then MatrixParser.execute(token_els, trans: true)
                   when 'LIMIT'    then LimitParser.execute(token_els)
                   when 'INTEGRAL' then IntegralParser.execute(token_els)
                   when 'DEF_FUNC' then FuncParser.execute(token_els)
                   when 'SIGMA'    then SigmaParser.execute(token_els)
                   when 'DIFFERENTIAL'
                     del_var, formula = token_els
                     "d/d#{del_var}(#{FormulaParser.execute(formula)})"
          end

          lexed.parsed!(parsed, $2)

        when /:LPRN(\d+):CONT(\d+):RPRN(\d+)/
          tokens_range = $1.to_i..$3.to_i
          token_val =

          lexed.parsed!(
            lexed.get_value($2).parentheses,
            tokens_range
          )

        when /:LBRCS(\d+):CONT(\d+):RBRCS(\d+)/
          tokens_range = $1.to_i..$3.to_i
          token_val = lexed.get_value($2)

          cont =
            case token_val
            when /#{ONEHASH}(#{CMA}#{ONEHASH})*/
              ListParser.execute(token_val)
            else
              token_val
            end

          lexed.parsed!(cont, tokens_range)

        when /:FUNCCN(\d+)/
          token_val = lexed.get_value($1)
          lexed.parsed!(token_val.parentheses, $1)

        when /:CONT(\d+)/
          lexed.parsed!(lexed.get_value($1), $1)


        # TODO
        when /:DEF_PROP(\d+)/
          $defing_sys << lexed.get_els($2).first

          lexed.parsed!('', $2)
        when /:END(\d+)/
          if $axioms
            $axioms << $defing_sys
          else
            $axioms = [$defing_sys]
          end
          $defing_sys = nil
          lexed.parsed!('', $2)
        when /:POST_AXIOM(\d+)/
          axiom = $axioms.find { |axiom| axiom.to_s == lexed.get_els($2).first }
          results = axiom.axioms.map do |axiom_str|
            $world << axiom_str
          end
          lexed.parsed!(results.join("\n"), $2)

        when /:UNKNOW(\d+)/
          raise %|'#{lexed.get_value($1)}' can not be parsed ;(|
        end
        lexed.squash!(($1.to_i)..($1.to_i+1)) if lexed.token_str =~ /:(?:CONT|R)(\d+):(?:CONT|R)(\d+)/
      end

      LangEqualizer.execute(
        lexed.values.join
      )
    end
    module_function :execute

    # FIXIT
    class LangEqualizer
      def self.execute(str)
        case $meta_info.lang
        when :ruby
          str.gsub(/\^/, '**')
        else
          str
        end
      end
    end
  end
end
