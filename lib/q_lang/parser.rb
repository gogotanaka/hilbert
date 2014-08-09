require 'q_lang/api'

require 'q_lang/lexer/cont_lexer'
require 'q_lang/lexer/func_lexer'

require 'q_lang/parser/base'
require 'q_lang/parser/matrix_parser'
require 'q_lang/parser/vector_parser'
require 'q_lang/parser/list_parser'
require 'q_lang/parser/func_parser'

module Qlang
  module Parser
    def execute(lexed)
      time = Time.now
      until lexed.token_str =~ /\A(:NLIN\d|:R\d)+\z/
        binding.pry if Time.now > time + 10

        case lexed.token_str
        when /:LPRN\d(:CONT\d):RPRN\d/
          cont_token_with_num = $1
          cont_lexed = Lexer::ContLexer.new(lexed.get_value(cont_token_with_num))

          case cont_lexed.token_str
          when /(:NUM\d)+(:SCLN\d|:NLIN\d)(:NUM\d)/
            cont = MatrixParser.execute(cont_lexed)
            lexed.squash_with_prn(cont_token_with_num, cont)
          when /(:NUM\d)+/
            cont = VectorParser.execute(cont_lexed)
            lexed.squash_with_prn(cont_token_with_num, cont)
          end

        when /:LBRC\d(:CONT\d):RBRC\d/
          cont_token_with_num = $1
          cont_lexed = Lexer::ContLexer.new(lexed.get_value(cont_token_with_num))

          case cont_lexed.token_str
          when /(:OTHER\d:CLN\d(:STR\d|:NUM\d|:R\d):CMA)*(:OTHER\d:CLN\d(:STR\d|:NUM\d|:R\d))/
            cont = ListParser.execute(cont_lexed)
            lexed.squash_with_prn(cont_token_with_num, cont)
          end

        when /:FUNC\d/
          cont_token_with_num = $&
          cont_lexed = Lexer::FuncLexer.new(lexed.get_value(cont_token_with_num))

          case cont_lexed.token_str
          when /:FDEF\d:EQL\d:OTHER\d/
            cont = FuncParser.execute(cont_lexed)
            lexed.ch_value(cont_token_with_num, cont)
            lexed.ch_token(cont_token_with_num, :R)
          end

        when /:CONT\d/
          lexed.ch_token($&, :R)
        end

        lexed.squash_to_cont($1, 2) if lexed.token_str =~ /(:CONT\d|:R\d)(:CONT\d|:R\d)/
      end
      lexed.fix_r_txt!
      lexed.values.join
    end
    module_function :execute
  end
end
