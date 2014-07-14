module Dydx
  module Algebra
    module Operator
      module Parts
        module Formula
          %w(+ *).map(&:to_sym).each do |op|
            define_method(op) do |rtr|
              if self.operator == op
                if f.combinable?(rtr, op)
                  _(
                    _(trs[0], op, rtr), op, trs[1]
                  )
                elsif g.combinable?(rtr, op)
                  _(
                    _(trs[1], op, rtr), op, trs[0]
                  )
                else
                  super(rtr)
                end
              elsif formula?(op.sub) && openable?(op, rtr)
                _(
                  _(trs[0], op, rtr), op.sub, _(trs[1], op, rtr)
                )
              elsif formula?(op.super) && rtr.formula?(op.super)
                cmn_fct = (trs & rtr.trs).first
                return super(rtr) unless cmn_fct

                if op.super.commutative?
                  _(
                    cmn_fct, op.super, _(delete(cmn_fct), op, rtr.delete(cmn_fct))
                  )
                else
                  return super(rtr) if index(cmn_fct) != rtr.index(cmn_fct)

                  case index(cmn_fct)
                  when 0
                    _(
                      cmn_fct, op.super, _(delete(cmn_fct), op.sub, rtr.delete(cmn_fct))
                    )
                  when 1
                    _(
                      _(delete(cmn_fct), op, rtr.delete(cmn_fct)), op.super, cmn_fct
                    )
                  end
                end
              elsif formula?(op.super) && rtr.inverse?(op) && rtr.x.formula?(op.super)
                cmn_fct = (trs & rtr.x.trs).first
                return super(rtr) unless cmn_fct

                if op.super.commutative?
                  _(
                    cmn_fct, op.super, _(delete(cmn_fct), op.inv, rtr.x.delete(cmn_fct))
                  )
                else
                  return super(rtr) if index(cmn_fct) != rtr.x.index(cmn_fct)
                  case index(cmn_fct)
                  when 0
                    _(
                      cmn_fct, op.super, _(delete(cmn_fct), op.sub.inv, rtr.x.delete(cmn_fct))
                    )
                  when 1
                    _(
                      _(delete(cmn_fct), op.inv, rtr.x.delete(cmn_fct)), op.super, cmn_fct
                    )
                  end
                end
              else
                super(rtr)
              end
            end
          end

          %w(**).map(&:to_sym).each do |op|
            define_method(op) do |rtr|
              if formula?(op.sub) && openable?(op, rtr)
                _(
                  _(trs[0], op, rtr), op.sub, _(trs[1], op, rtr)
                )
              else
                super(rtr)
              end
            end
          end
        end
      end
    end
  end
end
