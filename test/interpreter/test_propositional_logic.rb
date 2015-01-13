require 'minitest_helper'

class TestPropositionalLogic < TestInterpreterBase
  def setup
    $world.clear!
  end

  # TODO: opposite
  def assert_iq_equal(output, input)
    assert_equal(output, Hilbert::Iq.execute(input))
  end

  def test_ex1
    assert_iq_equal('Defined: A is TRUE', 'A')
    assert_iq_equal('Evaluate: A is TRUE', 'A?')
    assert_iq_equal('Evaluate: B is UNDEFINED', 'B?')
    assert_iq_equal('Defined: A->B is TRUE', "A->B")
    assert_iq_equal('Evaluate: B is TRUE', 'B?')
  end

  def test_ex2
    assert_iq_equal('Evaluate: A is UNDEFINED', 'A?')
    assert_iq_equal('Defined: ~A is TRUE', '~A')
    assert_iq_equal('Evaluate: A is FALSE', 'A?')
  end

  def test_ex3
    assert_iq_equal('Defined: A <-> B is TRUE', 'A <-> B')
    assert_iq_equal('Defined: B is TRUE', 'B')
    assert_iq_equal('Evaluate: A is TRUE', 'A?')
  end

  def test_ex4
    assert_iq_equal('Evaluate: A is UNDEFINED', 'A ?')
    assert_iq_equal('Defined: ~A is TRUE', '~A')
    assert_iq_equal('Evaluate: A is FALSE', 'A ?')
  end


  def test_syllogisms
    assert_iq_equal('Evaluate: A is UNDEFINED', 'A?')
    assert_iq_equal('Evaluate: A -> C is UNDEFINED', 'A -> C ?')
    assert_iq_equal('Defined: A -> B is TRUE', 'A -> B')
    assert_iq_equal('Defined: B -> C is TRUE', 'B -> C')
    assert_iq_equal('Evaluate: A -> C is TRUE', 'A -> C ?')
  end

  def test_paradox?
    assert_iq_equal('FALSE', 'paradox?')
    assert_iq_equal('Defined: A is TRUE', 'A')
    assert_iq_equal('FALSE', 'paradox?')
    assert_iq_equal('Defined: ~A is TRUE', '~A')
    assert_iq_equal('TRUE', 'paradox?')
  end

  def test_axiom_sys
    assert_iq_equal('', 'Axiom MY_AXIOM')
    assert_iq_equal('', 'def A -> B')
    assert_iq_equal('', 'end')
    assert_iq_equal('Defined: A -> B is TRUE', 'postulate MY_AXIOM')
  end

  def test_axiom_sys2
    assert_iq_equal('', 'Axiom MY_AXIOM2')
    assert_iq_equal('', 'def A -> B')
    assert_iq_equal('', 'def B -> C')
    assert_iq_equal('', 'end')
    assert_iq_equal('Defined: B -> C is TRUE', 'postulate MY_AXIOM2')
  end
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
