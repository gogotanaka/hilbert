#!/bin/env ruby
# encoding: utf-8

module Hilbert
  module World
    module PropositionalLogic
      module Operator
        def ~@
          if    is_neg?  then p
          elsif is_form? then vars.map(&:~).inject(reope)
          else                NEG.new(self)
          end
        end

        def *(q)
          case q
          when Taut  then self
          when UTaut then $utout
          when self  then self
          else
            if neg?(q) then $utout
            else            FORM.new([self, q], :*)
            end
          end
        end

        def +(q)
          case q
          when Taut  then $tout
          when UTaut then self
          when self  then self
          else
            if neg?(q) then $tout
            else            FORM.new([self, q], :+)
            end
          end
        end

        def >=(q)
          (~self + q)
        end

        def <=>(q)
          (self >= q) * (q >= self)
        end
      end

      module Utils
        def neg?(p)
          (is_neg? && self.p == p) || (p.is_neg? && p.p == self)
        end

        def is_neg?
          is_a?(NEG)
        end

        def is_form?(ope=nil)
          return is_a?(FORM) && @ope == ope if ope
          is_a?(FORM)
        end

        def is_or?
          is_form?(:+)
        end

        def is_and?
          is_form?(:*)
        end

        def include?(p)
          false
        end

        def dpll!
          !!!!!!!!!!!!self
        end
      end

      module Base; include Operator; include Utils end

      # Tautology
      class Taut
        include Base
        def ~@;   $utout end
        def +(q); $tout  end
        def *(q); q      end
        def !@;   $tout  end
        def to_s; 'TRUE' end
      end
      $tout = Taut.new

      # Non Tautology
      class UTaut
        include Base
        def ~@;   $tout   end
        def +(q); q       end
        def *(q); $utout  end
        def !@;   $utout  end
        def to_s; 'FALSE' end
      end
      $utout = UTaut.new

      class Atom < Struct.new(:p)
        include Base
        def to_s;          p.to_s      end
        def !@;            self        end
        def depth;         1           end
      end

      class NEG < Struct.new(:p)
        include Base
        def to_s;          "~#{p}"      end
        def !@;             ~(!p)       end
        def depth;          p.depth+1   end
      end

      class FORM
        include Base
        attr_reader :vars, :ope
        def initialize(vars, ope)
          @vars = vars.map { |var| var.is_form?(ope) ? var.vars : var }.flatten
          @ope = ope
        end

        def to_s; "(#{vars.map(&:to_s).join(loope)})" end

        def !@
          if is_or? && (and_form = vars.find { |var| var.is_and? })
            and_form.vars.map { |a| a + FORM.new((vars - [and_form]), :+) }.inject(:*)
          elsif are_there_neg?
            is_or? ? $tout : $utout
          else
            vars.map(&:!).inject(ope)
          end
        end

        def depth;       [p.depth, q.depth].max+1;     end

        def include?(p)
          vars.include?(p)
        end

        def loope
          ope == :* ? '&' : '|'
        end

        def reope
          is_and? ? :+ : :*
        end

        private
          def are_there_neg?
            pvars = vars.reject { |var| var.is_neg? }
            nvars = vars.select { |var| var.is_neg? }
            pvars.any? { |pvar|
              nvars.any? { |nvar| nvar.neg?(pvar) }
            }
          end
      end
    end
  end
end
