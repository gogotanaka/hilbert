require "q_lang/version"
require 'q_lang/lexer'
require 'q_lang/parser'

require 'q_lang/exec'

require "kconv"

require 'dydx'
include Dydx

module QLang
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
  end
end

Q = QLang
