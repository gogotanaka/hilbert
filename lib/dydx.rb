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
    return super unless (method_name[0] == 'd' && method_name.size <= 2)
    method_name.slice!(0)
    Delta.new(method_name.empty? ? nil : method_name.to_sym, args.first)
  end
end
