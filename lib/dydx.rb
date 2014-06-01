require 'dydx/helper'
require 'dydx/algebra'
require 'dydx/delta'
require 'dydx/function'
require 'dydx/integrand'

module Dydx
  include Algebra
  %w(f g h).each do |functioner|
    define_method(functioner) do |*vars|
      function = eval("$#{functioner}")
      return eval("$#{functioner} = Function.new(*vars)") unless function

      raise ArgumentError, "invalid number of values (#{vars.count} for #{function.vars.count})" unless function.vars.count == vars.count
      return function if function.vars == vars
      return function unless function.algebra

      subst_hash = Hash[*[function.vars, vars].transpose.flatten]
      begin
        function.algebra.subst(subst_hash).to_f
      rescue ArgumentError
        function.algebra.subst(subst_hash)
      end
    end
  end

  def S(function, delta)
    Integrand.new(function, delta.var)
  end

  def d
    Delta.new
  end

  def reset
    $f, $g, $h = nil, nil, nil
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

  private

  def substitute(vars, function)
    string = function.algebra.to_s
    function.vars.each_with_index { |var, i| string.gsub!(var.to_s, vars[i].to_s) }
    string
  end

  def all_vars_num?(vars)
    vars.all? { |v| v.is_a?(Numeric) }
  end

  def rename_for_calc(string)
    # TODO: need more refactoring...
    string.gsub!('cos', 'Math.cos')
    string.gsub!('sin', 'Math.sin')
    string.gsub!('log', 'Math.log')
    string.gsub!(' e ', ' Math::E ')
    string.gsub!('pi', 'Math::PI')
    string
  end
end
