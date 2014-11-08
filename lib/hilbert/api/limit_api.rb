module Hilbert
  module Api
    module LimitApi
      def self.execute(formula, var, close_to)
        case $meta_info.lang
        # TODO: I know what you want to say.......!
        when :ruby
          case close_to
          when 'oo'
            "temp_cal_f(#{var}) <= #{formula};
             temp_cal_f(100000)"
          else
            "temp_cal_f(#{var}) <= #{formula};
             temp_cal_f(#{close_to} + Float::EPSILON ** 20)"
          end
        when :inter
          Dydx::API.store_func(eval(var), eval(formula), :tmp)
          Dydx::API.eval_func(eval(close_to) + Float::EPSILON ** 20, :tmp)
        else
          fail "List is not implemented for #{$meta_info.lang_str}"
        end
      end
    end
  end
end
