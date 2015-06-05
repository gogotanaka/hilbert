module Hilbert
  module Api
    module IntegralApi
      def execute(func, delta, range)
        a, b = range.split('..')
        case $meta_info.lang
        when :ruby
          "S(#{func}, #{delta})[#{a}, #{b}]"
        else
          fail "Integral is not implemented for #{$meta_info.lang_str}"
        end
      end
      module_function :execute
    end
  end
end
