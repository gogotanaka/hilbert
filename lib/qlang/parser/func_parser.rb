module Qlang
  module Parser
    module FuncParser
      include Base
      def execute(lexed)
        lexed.fix_r_txt!
        fdef_ary = lexed[0][:FDEF].split('')
        func_name = fdef_ary.shift
        args = fdef_ary.join.rms!('(', ')', ',', ' ').split('')

        FuncApi.execute(func_name, args, FomlParser.execute(lexed[-1][:FOML]))
      end
      module_function :execute

      # FIX:
      module FomlParser
        def execute(lexed)
          ss = StringScanner.new(lexed)
          result = ''
          until ss.eos?
            { EXP: /\^/, MUL: /(pi|[1-9a-z]){2,}/, SNGL: /(pi|[1-9a-z])/, OTHER: /([^\^1-9a-z]|^pi)+/ }.each do |token , rgx|
              if ss.scan(rgx)
                item = case token
                when :EXP
                  $type == :Ruby ? '**' : '^'
                when :MUL
                  sss = StringScanner.new(ss[0])
                  ary = []
                  until sss.eos?
                    [/pi/, /[1-9a-z]/].each do |rgx2|
                      ary << sss[0] if sss.scan(rgx2)
                    end
                  end
                  ary.join(' * ')
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
