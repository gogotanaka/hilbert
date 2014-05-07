module Dydx
  Fixnum.class_eval do
    %w(+ - * / ^).each do |operator|
      define_method(operator) do |g|
        if g.is_a?(Symbol) ||
          g.is_a?(Formula) ||
          g.is_a?(Num) ||
          g.is_a?(Log) ||
          g.is_a?(E) ||
          %w(/ ^).include?(operator)

          _(self).send(operator.to_sym, g)
        else
          (to_f.send(operator.to_sym, g)).to_i
        end
      end
    end
    def d(sym=:x)
      _(0)
    end
  end
end
