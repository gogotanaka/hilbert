module QLang
  module Api
    module MatrixApi
      def execute(rows)
        row_count = rows.count
        column_count = rows.first.count
        case $type
        when :R
          "matrix(#{VectorApi.execute(rows.flatten)}, #{row_count}, #{column_count}, byrow = TRUE)"
        when :Ruby
          arys_str = rows.map { |row| "[#{row.join(', ')}]" }.join(', ')
          "Matrix[#{arys_str}]"
        end
      end
      module_function :execute
    end
  end
end
