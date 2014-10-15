module Qlang
  module Parser
    module MatrixParser
      include Base
      def execute(lexed_string, trans: false)
        lexed_string.rms!(')','(', 't')
        rows = lexed_string.split(/ *; */).map(&:split_by_sp)
        rows.all? { |row| row.count == rows.first.count }
        if trans
          rows = rows.transpose
        end
        MatrixApi.execute(rows)
      end
      module_function :execute
    end
  end
end
