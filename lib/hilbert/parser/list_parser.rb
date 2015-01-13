module Hilbert
  module Parser
    module ListParser
      include ::Hilbert::Api
      def execute(lexed)
        arys = lexed.split(/ *, */).map { |e| e.split(/ *: */).map { |e2| e2.delete(' ') } }
        ListApi.execute(arys)
      end
      module_function :execute
    end
  end
end
