module Qlang
  module Parser
    # FIX:
    module FormulaParser
      def execute(lexed)
        ss = StringScanner.new(lexed)
        result = ''
        until ss.eos?
          { EXP: /\^/, BFUNC: /sin|cos|tan|log/, MUL: /(pi|[1-9a-z]){2,}/, SNGL: /(pi|[1-9a-z])/, OTHER: /([^\^1-9a-z]|^pi)+/ }.each do |token , rgx|
            if ss.scan(rgx)
              item = case token
              when :EXP
                $meta_info.lang == :ruby ? '**' : '^'
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
