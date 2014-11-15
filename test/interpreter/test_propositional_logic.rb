require 'minitest_helper'

class TestPropositionalLogic < TestInterpreterBase
  def setup
  end

  # def test_general
  #   assert_iq_equal('Defined: A is true', "A")
  #   assert_iq_equal('Evaluate: B is undefined', "B?")
  #   assert_iq_equal('Defined: A->B is true', "A->B")
  #   assert_iq_equal('Evaluate: B is true', "B?")
  # end

  def test_legacy
    # assert_iq_equal('Defined: P(1) is true', "P(1)")
    # assert_iq_equal('Evaluate: P(1) is true', 'P?(1)')
    # assert_iq_equal('Evaluate: P(2) is undefined', 'P?(2)')
    # assert_iq_equal('Evaluate: Q(1) is undefined', 'Q?(1)')
    # assert_equal(
    #   "Defined: A[x] P(x) -> A[x] Q(x) is true",
    #   $world.truth.def_impli(['P', :all, true], ['Q', :all, true])
    # )
    # assert_iq_equal('Evaluate: Q(1) is true', 'Q?(1)')
    #
    # assert_iq_equal('Evaluate: Q(2) is undefined', 'Q?(2)')
    #
    # $world.truth.reset!
    # assert_iq_equal("Defined: Human('gogo1') is true", "Human('gogo1')")
    # assert_equal(
    #   "\"Defined: Human(\\'gogo1\\') -> WillDie(\\'gogo1\\') is true\"",
    #   $world.truth.def_impli(['Human', 'gogo1', true], ['WillDie', 'gogo1', true])
    # )
    # assert_iq_equal("Evaluate: WillDie('gogo1') is true", "WillDie?('gogo1')")
    # assert_iq_equal("Evaluate: WillDie('gogo2') is undefined", "WillDie?('gogo2')")
    # assert_iq_equal('Evaluate: Q(x) is true', 'Q?(x)')
  end
end
