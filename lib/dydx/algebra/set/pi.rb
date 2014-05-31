module Dydx
  module Algebra
    module Set
      class Pi < Base
        def differentiate(sym=:x)
          _(0)
        end
        alias_method :d, :differentiate

        def to_s
          'pi'
        end

        def subst(hash = {})
          Math::PI
        end
      end
    end
  end
end