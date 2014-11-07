module Hilbert
  module Parser
    module VectorParser
      include Base
      def execute(els)
        VectorApi.execute(
          els.first.rm(/\A +/).rm(/ +\z/).split_by_sp
        )
      end
      module_function :execute
    end
  end
end
