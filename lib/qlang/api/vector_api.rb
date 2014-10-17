module Qlang
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
          fail "Vector is not implemented for #{LANGS_HASH[$meta_info.lang.to_s]}"
        end
      end
      module_function :execute
    end
  end
end
