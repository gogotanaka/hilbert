require 'strscan'
require 'qlang/lexer/tokens'

module Qlang
  module Lexer
    class Base
      attr_accessor :lexeds
      include Tokens
      class << self
        attr_reader :token_hash

        def rule(pattern, &token)
          token ||= proc { :NULL }
          @token_hash ||= {}
          @token_hash[token.call] = pattern
        end
      end

      def initialize(str)
        ss = StringScanner.new(str)
        @lexeds = []
        until ss.eos?
          self.class.token_hash.each do |token, patter|
            if ss.scan(patter)
              (@lexeds << {token => ss[0]}) unless token == :NULL
              break
            end
          end
        end
      end

      # Accessor
      ## GET(without side effect)
      def get_value(num)
        @lexeds.map { |lexed| lexed.values.first }[num]
      end

      def token_str
        @lexeds.map.with_index { |lexed, i| ":#{lexed.keys.first}#{i}" }.join
      end

      ## POST(with side effect, without idempotence.)
      def parsed!(target, parsed)
        case target
          when Integer then parsed_at!(target, parsed)
          when Range   then parsed_between!(target, parsed)
        end
      end

      def squash!(range, token: :CONT)
        value = values[range].join
        range.count.times { @lexeds.delete_at(range.first) }
        @lexeds.insert(range.first, { token => value })
      end

      # Legacy Accessor
      def values
        @lexeds.map { |lexed| lexed.values.first }
      end

      def [](index)
        @lexeds[index]
      end

      def fix_r_txt!
        @lexeds.map! do |hash|
          if value = (hash[:R] || hash[:CONT])
            ary = hash.first
            ary[1] = value.gsub(/:%\|/,'').gsub(/\|%:/,'')
            hash = Hash[*ary]
          end
          hash
        end
      end

      private
        def parsed_at!(token_position, parsed)
          @lexeds.delete_at(token_position)
          @lexeds.insert(token_position, { R: parsed })
        end

        def parsed_between!(token_range, parsed)
          start_pos = token_range.first
          token_range.count.times do
            @lexeds.delete_at(start_pos)
          end
          @lexeds.insert(start_pos, { R: parsed })
        end

    end
  end
end
