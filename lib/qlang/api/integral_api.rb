module Qlang
  module Api
    module IntegralApi
      def execute(func, delta, range)
        a, b = range.split('..')
        case $type
        when :R
          fail 'Integral is not implemented for R'
        when :Ruby
          "S(#{func}, #{delta})[#{a}, #{b}]"
        end

      end
      module_function :execute
    end
  end
end
