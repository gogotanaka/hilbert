module Qlang
  module Api
    module IntegralApi
      def execute(func, delta, range)
        a, b = range.split('..')
        case $type
        when :r
          fail 'Integral is not implemented for R'
        when :ruby
          "S(#{func}, #{delta})[#{a}, #{b}]"
        end

      end
      module_function :execute
    end
  end
end
