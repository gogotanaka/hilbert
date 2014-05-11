module Dydx
  module Algebra
    module Operator
      module Parts
        module Interface
          %w(+ - * / ^).each do |operator|
            define_method(operator) do |x|
              x = ::Set::Num.new(x) if x.is_a?(Fixnum)
              super(x)
            end
          end
        end
      end
    end
  end
end
