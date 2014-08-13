module Qlang
  module Parser
    module FuncParser
      include Base
      def execute(lexed)
        lexed.fix_r_txt!
        fdef_ary = lexed[0][:FDEF].split('')
        func_name = fdef_ary.shift
        args = fdef_ary.join.rms('(', ')', ',', ' ').split('')

        FuncApi.execute(func_name, args, FomlParser.execute(lexed[-1][:FOML]))
      end
      module_function :execute

      # FIX:
      module FomlParser
        def execute(lexed)
          ss = StringScanner.new(lexed)
          result = ''
          until ss.eos?
            { EXP: /\^/, MUL: /[1-9a-z]{2,}/, SNGL: /[1-9a-z]/, OTHER: /[^\^1-9a-z]+/ }.each do |token , rgx|
              if ss.scan(rgx)
                item = case token
                when :EXP
                  $type == :Ruby ? '**' : '^'
                when :MUL
                  ss[0].split('').join(' * ')
                else
                  ss[0]
                end
                result += item
                break
              end
            end
          end
          result
        end
        module_function :execute
      end
    end
  end
end
