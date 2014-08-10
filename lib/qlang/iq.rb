module Qlang
  module Iq
    def execute(code)
      ruby_obj = eval Q.to_ruby.compile(code)
      [Matrix, Vector].include?(ruby_obj.class) ? ruby_obj.to_q : ruby_obj
    end
    module_function :execute
  end
end
