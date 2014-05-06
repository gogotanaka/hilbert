module Dydx
  module Operator
    module Parts
      module Interface
        %w(+ - * / ^).each do |operator|
          define_method(operator) do |x|
            x = _(x) if x.is_a?(Fixnum)
            super(x)
          end
        end
      end
    end
  end
end