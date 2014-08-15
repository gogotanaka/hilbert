module Qlang
  module Parser
    module IntegralParser
      include Base
      def execute(string)
        integrated, range = string.scan(/S *\((.+)\)\[(.+)\]/).first

        integrated.rm!(' ')

        IntegralApi.execute(integrated[0..-3], integrated[-2..-1], range)
      end
      module_function :execute
    end
  end
end
