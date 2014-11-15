require 'minitest_helper'

class TestLexer < MiniTest::Unit::TestCase
  def test_general
    lexeds = Hilbert::Lexer::WorldLexer.new('(A -> B) <-> (C|D)&(E&~R)'.delete(' ')).lexeds
    assert_equal(17, lexeds.count)


    lexeds.each { |lexed| FuncParser.push(lexed) }
    FuncParser.parsed_srt

    class Prop
      attr_accessor :var

      def initialize(var)
        @var = var
      end

      def >=(p)
        self
      end

      def <=>(p)
        self
      end

      def +(p)
        self
      end

      def *(p)
        self
      end

      def ~@
        self
      end
    end


  end
end
