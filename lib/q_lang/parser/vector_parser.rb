module QLang
  module Parser
    module VectorParser
      include Base
      def execute(lexed)
        VectorApi.execute(lexed.values)
      end
      module_function :execute
    end
  end
end
