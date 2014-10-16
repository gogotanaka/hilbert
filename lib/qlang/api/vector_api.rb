module Qlang
  module Api
    module VectorApi
      def execute(nums)
        case $type
        when :r
          "c(#{nums.join(', ')})"
        when :ruby
          "Vector[#{nums.join(', ')}]"
        else
          fail "Vector is not implemented for #{LANGS_HASH[$type.to_s]}"
        end
      end
      module_function :execute
    end
  end
end
