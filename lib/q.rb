require 'q/lexer'
require 'q/parser'

require 'q/exec'

require "kconv"

module Q
  $type = :R
  def compile(str)
    return super(str) unless str.is_a?(String)
    lexed = Lexer.execute(str)
    Kconv.tosjis(Parser.execute(lexed))
  end
  module_function :compile

  def to_ruby
    $type = :Ruby
    Q
  end
  module_function :to_ruby

  def to_r
    $type = :R
    Q
  end
  module_function :to_r
end
