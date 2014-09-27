module Qlang
  module Parser
    module MatrixParser
      include Base
      def execute(lexed_string)
        lexed_string.rms!(')','(')
        rows = lexed_string.split(/ *; */).map(&:split_by_sp)
        rows.all? { |row| row.count == rows.first.count }
        MatrixApi.execute(rows)
      end
      module_function :execute
    end
  end
end
