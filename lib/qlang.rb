# Ruby stlib
require 'kconv'
require 'matrix'
require 'singleton'
require 'yaml'

# Q core
require 'qlang/lexer'
require 'qlang/parser'
require 'qlang/utils/ruby_ext'
require "qlang/version"

module Qlang
  LANGS_HASH = YAML.load_file("./lib/qlang/utils/langs.yml")['langs']

  class MetaInfo
    include Singleton
    attr_accessor :lang, :opts

    def _load
      # compiles into R as default.
      lang = :r
    end
  end
  $meta_info = MetaInfo.instance

  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    LANGS_HASH.keys.each do |lang_name|
      define_method("to_#{lang_name}") do |*opts|
        $meta_info.lang = lang_name.to_sym
        $meta_info.opts = opts
        Qlang
      end
    end

  end
end

# Make alias as Q
Q = Qlang
