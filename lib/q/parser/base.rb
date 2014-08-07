module Q
  module Parser
    class Base
      def initialize(lexed)
        binding.pry
        rows = lexed.split(';')
        rows.all? { |row| row.count == rows.first.count }
        API::Matrix.execute(rows)
      end
    end
  end
end

module Q
  module API
    module Matrix
      def execute(rows)
        row_count = rows.count
        column_count = rows.first.count
        binding.pry
        "matrix(#{Vector.execute(rows.flatten)}, #{row_count}, #{column_count}, byrow = TRUE)"
      end
      module_function :execute
    end

    module Vector
      def execute(nums)
        "c(#{nums.join(', ')})"
      end
      module_function :execute
    end
  end
end
