module QLang
  module Api
    module VectorApi
      def execute(nums)
        case $type
        when :R
          "c(#{nums.join(', ')})"
        when :Ruby
          "Vector[#{nums.join(', ')}]"
        end
      end
      module_function :execute
    end
  end
end
