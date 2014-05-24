require 'dydx/helper'
require 'dydx/algebra'
require 'dydx/delta'
require 'dydx/function'
require 'dydx/integrand'

module Dydx
  include Algebra
  def f(*vars)
    if $f
      raise ArgumentError, "invalid number of values (#{vars.count} for #{$f.vars.count})" unless $f.vars.count == vars.count
      return $f if $f.vars == vars
      if $f.algebra
        string = $f.algebra.to_s
        $f.vars.each_with_index do |var, i|
          string.gsub!(var.to_s, vars[i].to_s)
        end
        eval(string)
      else
        $f
      end
    else
      $f = Function.new(*vars)
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
