module Dydx
  module Algebra
    module Operator
      module Parts
        module Interface
          %w(+ - * / ^).map(&:to_sym).each do |operator|
            define_method(operator) do |x|
              x = ::Set::Num.new(x) if x.is_a?(Fixnum)
              case operator
              when :-
                self + inverse(x, :+)
              when :/
                raise ZeroDivisionError if x.is_0?
                self * inverse(x, :*)
              else
                super(x)
              end
            end
          end
        end
      end
    end
  end
end
