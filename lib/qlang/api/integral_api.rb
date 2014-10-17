module Qlang
  module Api
    module IntegralApi
      def execute(func, delta, range)
        a, b = range.split('..')
        case $meta_info.lang
        when :ruby
          "S(#{func}, #{delta})[#{a}, #{b}]"
        else
          fail "Integral is not implemented for #{LANGS_HASH[$meta_info.lang.to_s]}"
        end

      end
      module_function :execute
    end
  end
end
