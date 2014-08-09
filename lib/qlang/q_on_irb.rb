module Qlang
  module QOnIrb
    def _(code)
      super(code) unless code.is_a?(String)
      Q.to_ruby.compile()
    end
  end
end
