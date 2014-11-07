require 'dydx'
include Dydx

module Hilbert
  module Iq
    class Dydx::Algebra::Formula
      # FIX:
      def to_q
        str = to_s.gsub(/\*\*/, '^').rm(' * ')
        str.equalize!
      end
    end

    def self.execute(code)
      ruby_code = Hilbert.to_ruby.compile(code.encode('utf-8'))
      ruby_obj = eval(ruby_code)

      optimize_output(ruby_obj).encode('utf-8')
    rescue SyntaxError
      # TODO: emergency
      case ruby_code
      when /(\d)+(\w)/
        execute("#{$1} * #{$2}")
      end
    end

    def self.optimize_output(ruby_obj)

      case ruby_obj
      when Matrix, Vector, Dydx::Algebra::Formula
        ruby_obj.to_q
      when Numeric
        # TODO: I know you wanna way..
        if    ruby_obj > 10000.0            then 'oo'
        elsif ruby_obj < -10000.0           then '-oo'
        elsif ruby_obj.abs < Float::EPSILON then '0.0'
        else                                     ruby_obj.to_s.equalize!
        end
      else
        str = ruby_obj.to_s
        str.equalize!
      end
    end
  end
end
