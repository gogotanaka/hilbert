# Use Dydx -> https://github.com/gogotanaka/dydx
require 'dydx'
include Dydx

require "q_lang/version"
require 'q_lang/lexer'
require 'q_lang/parser'

require 'q_lang/exec'

require 'q_lang/q_on_irb'

require "kconv"

module QLang
  # compiles into R as default.
  $type = :R

  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    def to_ruby
      $type = :Ruby
      QLang
    end

    def to_r
      $type = :R
      QLang
    end

    def to_haskell
      $type = :Hskl
      QLang
    end

    def to_scala
      $type = :Scla
      QLang
    end

    def to_java
      $type = :Scla
      QLang
    end
  end
end

# Make alias as Q
Q = QLang
