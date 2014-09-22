require 'strscan'

module Qlang
  module Lexer
    class Base
      NUM = '[0-9]'
      VAR = '[a-z]'
      FUNCV = '[a-zA-Z]'
      VARNUM = '[0-9a-z]'
      ANYSP = ' *'
      NONL = '[^\r\n]'
      FUNCTION = "#{FUNCV}\\(#{ANYSP}#{VARNUM}(#{ANYSP},#{ANYSP}#{VARNUM})*\\)"

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

      def get_value(token_with_num)
        num = to_num(token_with_num)
        values[num]
      end

      def squash_with_prn(token_with_num, value)
        num = to_num(token_with_num)
        3.times do
          @lexeds.delete_at(num - 1)
        end
        @lexeds.insert(num - 1, {R: ":%|#{value}|%:"})
      end

      def squash_to_cont(token_with_num, count)
        num = to_num(token_with_num)
        value = ''
        count.times do
          value += values[num]
          @lexeds.delete_at(num)
        end
        @lexeds.insert(num, {CONT: value})
      end

      def ch_token(token_with_num, token)
        num = to_num(token_with_num)
        before_hash = @lexeds.delete_at(num)
        @lexeds.insert(num, {token => before_hash.values.first})
      end

      def tokens
        @lexeds.map { |lexed| lexed.keys.first }
      end

      def token_with_nums
        @lexeds.map.with_index { |lexed, i| ":#{lexed.keys.first}#{i}" }
      end

      def ch_value(token_with_num, value)
        num = to_num(token_with_num)
        before_hash = @lexeds.delete_at(num)
        @lexeds.insert(num, {before_hash.keys.first => value })
      end

      def values
        @lexeds.map { |lexed| lexed.values.first }
      end

      def token_str
        token_with_nums.join
      end

      def [](index)
        @lexeds[index]
      end

      def split(separator)
        values.chunk { |e| e == separator }.reject { |sep, _| sep }.map { |_, ans| ans }
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

        def to_num(token_with_num)
          token_with_num =~ /\d+/
          $&.to_i
        end
    end
  end
end
