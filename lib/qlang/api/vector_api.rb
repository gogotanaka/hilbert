module Qlang
  module Api
    module VectorApi
      def execute(nums)
        case $type
        when :r
          "c(#{nums.join(', ')})"
        when :ruby
          "Vector[#{nums.join(', ')}]"
        end
      end
      module_function :execute
    end
  end
end
