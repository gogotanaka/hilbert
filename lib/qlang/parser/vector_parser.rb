module Qlang
  module Parser
    module VectorParser
      include Base
      def execute(lexed_string)
        lexed_string.rms!(/ *\( */, / *\) */)
        elements = lexed_string.split_by_sp
        VectorApi.execute(elements)
      end
      module_function :execute
    end
  end
end
