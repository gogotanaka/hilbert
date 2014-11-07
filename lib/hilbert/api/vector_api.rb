module Hilbert
  module Api
    module VectorApi
      def execute(nums)
        case $meta_info.lang
        when :r
          "c(#{nums.join(', ')})"
        when :ruby
          "Vector[#{nums.join(', ')}]"
        when :python
          "array([#{nums.join(', ')}])"
        else
          fail "Vector is not implemented for #{$meta_info.lang_str}"
        end
      end
      module_function :execute
    end
  end
end
