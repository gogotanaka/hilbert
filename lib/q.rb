require 'q/lexer'
require 'q/parser'

require 'q/exec'

require "kconv"

module Q
  $type = :R
  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    def to_ruby
      $type = :Ruby
      Q
    end

    def to_r
      $type = :R
      Q
    end
  end
end
