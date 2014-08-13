module Qlang
  module Iq
    class Dydx::Algebra::Formula
      # FIX:
      def to_q
        str = to_s.gsub(/\*\*/, '^').rm(' * ')
        str.equalize!
      end
    end
    def execute(code)
      ruby_obj = eval Q.to_ruby.compile(code)
      output = case ruby_obj
      when Matrix, Vector, Dydx::Algebra::Formula
        ruby_obj.to_q
      when Float::INFINITY
        'oo'
      when - Float::INFINITY
        '-oo'
      else
        str = ruby_obj.to_s
        str.equalize!
      end
    end
    module_function :execute
  end
end
