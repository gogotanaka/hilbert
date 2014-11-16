require 'minitest_helper'

class TestLexer < MiniTest::Unit::TestCase
  def test_general
    lexeds = Hilbert::Lexer::WorldLexer.execute('(A -> B) <-> (C|D)&(E&~R)')
    assert_equal(22, lexeds.count)
    Hilbert::Parser::WorldParser.execute(lexeds)
    assert_equal(
      "($world.atom(:A)  >=  $world.atom(:B))  <=>  ($world.atom(:C) + $world.atom(:D)) * ($world.atom(:E) *  ~$world.atom(:R))",
      Hilbert::Parser::WorldParser.parsed_srt
    )


    lexeds = Hilbert::Lexer::WorldLexer.execute('(A & (A -> B)) -> B')
    Hilbert::Parser::WorldParser.execute(lexeds)
    assert_equal(
       "($world.atom(:A)  *  ($world.atom(:A)  >=  $world.atom(:B)))  >=  $world.atom(:B)",
      Hilbert::Parser::WorldParser.parsed_srt
    )
  end
end
