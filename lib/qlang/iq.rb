module Qlang
  module Iq
    def execute(code)
      eval Q.to_ruby.compile(code)
    end
    module_function :execute
  end
end
