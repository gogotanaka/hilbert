module Q
  module Api
    module MatrixApi
      def execute(rows)
        row_count = rows.count
        column_count = rows.first.count
        "matrix(#{VectorApi.execute(rows.flatten)}, #{row_count}, #{column_count}, byrow = TRUE)"
      end
      module_function :execute
    end
  end
end
