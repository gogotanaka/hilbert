module Hilbert
  module Api
    module SigmaApi
      def self.execute(formula, var, from, to)
        case $meta_info.lang
        # TODO: I know what you want to say.
        when :ruby
          "temp_cal_f(#{var}) <= #{formula};
           (#{from}..#{to}).inject(0) {|sum, i| sum+=temp_cal_f(i) }"
        else
          fail "List is not implemented for #{$meta_info.lang_str}"
        end
      end
    end
  end
end
