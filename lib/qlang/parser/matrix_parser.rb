module Qlang
  module Parser
    module MatrixParser
      include Base
      def execute(els, opts={trans: false})
        trans = opts[:trans]
        rows = els.first.split(/ *(?:;|\n) */).map(&:split_by_sp)
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
