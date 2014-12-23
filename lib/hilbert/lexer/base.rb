require 'strscan'
require 'hilbert/lexer/tokens'

module Hilbert
  module Lexer
    class Base
      attr_accessor :lexeds
      include Tokens
      class << self
        attr_reader :token_rule_hash

        def rule(pattern, &token)
          token ||= proc { :NULL }
          @token_rule_hash ||= {}
          @token_rule_hash[pattern] = token.call
        end

        def clear!
          @token_rule_hash = {}
        end

        def execute(str)
          new(str).lexeds
        end
      end

      def initialize(str)
        ss = StringScanner.new(str)
        @lexeds = []
        until ss.eos?
          scan_rslt, ss = scan(ss)
          if scan_rslt
            @lexeds << scan_rslt unless scan_rslt[:token] == :NULL
          else
            fail "I'm so sorry, something wrong. Please feel free to report this. [DEBUGG CODE30]"
          end
        end
      end

      def scan(ss)
        scan_rslt = nil
        token_rule_hash.each do |pattern, token|
          if ss.scan(pattern)
            scan_rslt = {
              token: token,
              value: ss[0],
              els: 4.times.inject([]) { |s,i|s << ss[i+1] }.compact
            }
            break
          end
        end
        [scan_rslt, ss]
      end

      # Accessor
      ## GET(without side effect)
      def get_value(num)
        num = num.to_i
        @lexeds[num][:value]
      end

      def get_els(num)
        num = num.to_i
        @lexeds[num][:els]
      end

      def token_str
        @lexeds.map.with_index { |lexed, i| ":#{lexed[:token]}#{i}" }.join
      end

      def token_rule_hash
        self.class.token_rule_hash
      end

      ## POST(with side effect, without idempotence.)
      def parsed!(parsed, target)
        case target
        when Range
          parsed_between!((target.first.to_i)..(target.last.to_i), parsed)
        else
          parsed_at!(target.to_i, parsed)
        end
      end

      # squash!(range, token: :CONT)
      def squash!(range, opts = { token: :CONT })
        token = opts[:token]
        range = (range.first.to_i)..(range.last.to_i)
        value = values[range].join
        range.count.times { @lexeds.delete_at(range.first) }
        @lexeds.insert(range.first, { token: token, value: value })
      end

      # Legacy Accessor
      def values
        @lexeds.map { |lexed| lexed[:value] }
      end

      private

      def parsed_at!(token_position, parsed)
        @lexeds.delete_at(token_position)
        @lexeds.insert(token_position, { token: :R, value: parsed })
      end

      def parsed_between!(token_range, parsed)
        start_pos = token_range.first
        token_range.count.times do
          @lexeds.delete_at(start_pos)
        end
        @lexeds.insert(start_pos, { token: :R, value: parsed })
      end
    end
  end
end
