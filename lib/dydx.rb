require 'dydx/helper'
require 'dydx/algebra'
require 'dydx/function'

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

  def f(*vars)
    if $f
      raise ArgumentError, "invalid number of values (#{vars.count} for #{$f.vars.count})" unless $f.vars.count == vars.count
      string = $f.algebra.to_s
      $f.vars.each_with_index do |var, i|
        string.gsub!(var.to_s, vars[i].to_s)
      end
      eval(string)
    else
      $f = Function.new(*vars)
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
