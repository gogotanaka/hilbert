# Use Dydx -> https://github.com/gogotanaka/dydx
require 'dydx'
include Dydx

require "qlang/version"
require 'qlang/lexer'
require 'qlang/parser'

require 'qlang/exec'

require 'qlang/iq'

require 'kconv'
require 'matrix'

module Qlang
  # compiles into R as default.
  $type = :r

  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    %w(ruby r haskell scala java).each do |lang_name|
      define_method("to_#{lang_name}") do
        $type = lang_name.to_sym
        Qlang
      end
    end

  end
end

# Make alias as Q
Q = Qlang
