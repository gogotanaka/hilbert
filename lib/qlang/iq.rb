module Qlang
  module Iq
    def execute(code)
      ruby_obj = eval Q.to_ruby.compile(code)
      case ruby_obj
      when Matrix, Vector
        ruby_obj.to_q
      when Float::INFINITY
        'oo'
      when - Float::INFINITY
        '-oo'
      else
        ruby_obj
      end
    end
    module_function :execute
  end
end
