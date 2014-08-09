module Q
  module Parser
    module MatrixParser
      include Base
      def execute(lexed)
        rows = lexed.split(';')
        rows.all? { |row| row.count == rows.first.count }
        MatrixApi.execute(rows)
      end
      module_function :execute
    end
  end
end
