require 'strscan'

module Qlang
  module Lexer
    class Base
      # FIRST TOKEN
      NUM = '[0-9]+'
      VAR = '[a-z]'
      FUNCV = '[a-zA-Z]'
      VARNUM = '[0-9a-z]'
      ANYSP = ' *'
      ANYSTR = '.+'
      NONL = '[^\r\n]'
      LPRN = '\('
      RPRN = '\)'
      LBRC = '\{'
      RBRC = '\}'
      CLN = '\:'
      SCLN = ';'
      CMA = '\,'
      SP = ' '

      # SECOND TOKEN
      class ::String
        def line_by(char)
          "#{self}(#{ANYSP}#{char}#{ANYSP}#{self})*"
        end
      end
      NUMS_BY_CMA = NUM.line_by(CMA)
      VARS_BY_CMA = VAR.line_by(CMA)
      VARNUMS_BY_CMA = VARNUM.line_by(CMA)
      NUMS_BY_SP = NUM.line_by(SP)

      # THIRD TOKEN
      class ::String
        def func_call
          "#{FUNCV}#{LPRN}#{ANYSP}#{self}*#{ANYSP}#{RPRN}"
        end
      end
      FUNCCN =  NUMS_BY_CMA.func_call
      FUNCCV = VARS_BY_CMA.func_call
      FUNCCVN =  VARNUMS_BY_CMA.func_call

      NUMS_BY_SP_BY_SCLN = NUMS_BY_SP.line_by(SCLN)





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
