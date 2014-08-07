module Q
  module Lexer
    class Base
      class << self
        def rule(pattern, &token)
          token ||= Proc.new { :NULL }
          @token_hash ||= {}
          @token_hash[token.call] = pattern
        end

        def token_hash
          @token_hash
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
        @lexeds.insert(num - 1, {R: "%R%|||#{value}|||"})
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

      def tokens
        @lexeds.map { |lexed| lexed.keys.first }
      end

      def token_with_nums
        @lexeds.map.with_index { |lexed, i| ":#{lexed.keys.first}#{i}" }
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
        values.chunk { |e| e == separator }.reject { |sep,ans| sep }.map { |sep,ans| ans }
      end

      def fix_r_txt
        @lexeds.map do |hash|
          if hash[:R] && hash[:R] =~ /\%R\%\|\|\|(.+)\|\|\|/
            hash[:R] = $1
          end
          hash
        end
      end

      private def to_num(token_with_num)
          token_with_num =~ /\d+/
          num = $&.to_i
        end
    end
  end
end
