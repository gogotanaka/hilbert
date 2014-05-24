require 'dydx/helper'
require 'dydx/algebra'
require 'dydx/delta'
require 'dydx/function'
require 'dydx/integrand'

module Dydx
  include Algebra
  %w(f g h).each do |functioner|
    define_method(functioner) do |*vars|
      if function = eval("$#{functioner}")
        raise ArgumentError, "invalid number of values (#{vars.count} for #{function.vars.count})" unless function.vars.count == vars.count
        return function if function.vars == vars
        if function.algebra
          string = function.algebra.to_s
          function.vars.each_with_index do |var, i|
            string.gsub!(var.to_s, vars[i].to_s)
          end
          eval(string)
        else
          function
        end
      else
        eval("$#{functioner} = Function.new(*vars)")
      end
    end
  end

  def S(function, delta)
    Integrand.new(function, delta.var)
  end

  def d
    Delta.new
  end

  def method_missing(method, *args, &block)
    method_name = method.to_s
    if method_name =~ /^d.$/
      Delta.new(method_name[1].to_sym, args.first)
    elsif method_name =~ /^[a-z]$/
      method_name.to_sym
    else
      super
    end
  end

  Float.class_eval do
    def ^(x)
      result = 1.0
      x.times{ result *= self }
      result
    end
  end
end
