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
require 'yaml'

module Qlang
  # compiles into R as default.
  $type = :r
  LANGS_HASH = YAML.load_file("./lib/qlang/utils/langs.yml")['langs']

  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    LANGS_HASH.keys.each do |lang_name|
      define_method("to_#{lang_name}") do
        $type = lang_name.to_sym
        Qlang
      end
    end

  end
end

# Make alias as Q
Q = Qlang
