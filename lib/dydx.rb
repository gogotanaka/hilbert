require 'dydx/helper'
require 'dydx/algebra'

module Dydx
  include Algebra
  class Delta
    attr_accessor :var, :function
    def initialize(var, function)
      @var      = var
      @function = function
    end

    def /(delta)
      if var
        eval("$#{var}").differentiate(delta.var)
      elsif delta.function
        delta.function.differentiate(delta.var)
      end
    end
  end

  def method_missing(method, *args, &block)
    method_name = method.to_s
    if method_name =~ /^d.?$/
      Delta.new(method_name[1] ?  method_name[1].to_sym : nil, args.first)
    elsif method_name =~ /^[a-z]$/
      method_name.to_sym
    else
      super
    end
  end
end
