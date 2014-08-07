module Q
  module Parser
    module ListParser
      include Base
      def execute(lexed)
        lexed.fix_r_txt
        arys = lexed.split(',').map { |ary| [ary[0], ary[2]] }
        ListApi.execute(arys)
      end
      module_function :execute
    end
  end
end
