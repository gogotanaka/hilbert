# Use Dydx -> https://github.com/gogotanaka/dydx
require 'dydx'
include Dydx

require "qlang/version"
require 'qlang/lexer'
require 'qlang/parser'

require 'qlang/exec'

require 'qlang/q_on_irb'

require "kconv"

module Qlang
  # compiles into R as default.
  $type = :R

  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    def to_ruby
      $type = :Ruby
      Qlang
    end

    def to_r
      $type = :R
      Qlang
    end

    def to_haskell
      $type = :Hskl
      Qlang
    end

    def to_scala
      $type = :Scla
      Qlang
    end

    def to_java
      $type = :Scla
      Qlang
    end
  end
end

# Make alias as Q
Q = Qlang
