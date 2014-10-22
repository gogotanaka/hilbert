module Qlang
  module Parser
    module MatrixParser
      include Base
      def execute(els, trans: false)
        rows = els.first.split(/ *; */).map(&:split_by_sp)
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
