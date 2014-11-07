# Ruby stlib
require 'kconv'
require 'matrix'
require 'singleton'
require 'yaml'

$:.unshift(File.dirname(__FILE__))
# Q core
require 'hilbert/meta_info'
require 'hilbert/utils/ruby_ext'
require 'hilbert/lexer'
require 'hilbert/parser'

module Hilbert
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
        Hilbert
      end
    end
  end

end
