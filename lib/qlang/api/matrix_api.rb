module Qlang
  module Api
    module MatrixApi
      def execute(rows)
        row_count = rows.count
        column_count = rows.first.count
        case $meta_info.lang
        when :r
          "matrix(#{VectorApi.execute(rows.flatten)}, #{row_count}, #{column_count}, byrow = TRUE)"
        when :ruby
          arys_str = rows.map { |row| "[#{row.join(', ')}]" }.join(', ')
          "Matrix[#{arys_str}]"
        else
          fail "Matrix is not implemented for #{$meta_info.lang_str}"
        end
      end
      module_function :execute
    end
  end
end
