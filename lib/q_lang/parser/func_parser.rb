module QLang
  module Parser
    module FuncParser
      include Base
      def execute(lexed)
        lexed.fix_r_txt!
        fdef_ary = lexed[0][:FDEF].split('')
        func_name = fdef_ary.shift
        args = fdef_ary.join.rms('(', ')', ',', ' ').split('')

        FuncApi.execute(func_name, args, lexed[-1][:OTHER])
      end
      module_function :execute
    end
  end
end
