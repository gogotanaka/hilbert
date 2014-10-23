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
  # $meta_info indicate what and how to do.
  class MetaInfo
    include Singleton
    attr_accessor :lang, :opts, :mode

    LANGS_HASH = YAML.load_file("./lib/qlang/utils/langs.yml")['langs']

    def _load
      # compiles into R as default.
      lang = :r
    end

    def langs_hash
      LANGS_HASH
    end

    def lang_str
      LANGS_HASH[@lang.to_s]
    end
  end
  $meta_info = MetaInfo.instance

  class << self
    def compile(str)
      lexed = Lexer.execute(str)
      Kconv.tosjis(Parser.execute(lexed))
    end

    $meta_info.langs_hash.keys.each do |lang_name|
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
