class TestPropLogic < MiniTest::Unit::TestCase
  # Fixit:
  $p = $world.atom(:P)
  $q = $world.atom(:Q)
  $r = $world.atom(:R)
  def setup

  end
  def assert_to_s(exp, obj)
    assert_equal(exp, ((!!!!!!!obj).to_s))
  end

  def test_utils
    assert_equal(true, $p.neg?(~$p))
    assert_equal(true, (~$p).neg?($p))
    assert_equal(false, ($p).neg?($p))
    assert_equal(false, ($p).neg?($p))
    assert_equal(true, ($p + $q).include?($p))
    assert_equal(true, ($p + $q).include?($q))
  end

  def test_0_1
    assert_to_s("TRUE", $p + $tout)
    assert_to_s("TRUE", $tout + $p)
    assert_to_s("P", $p + $utout)
    assert_to_s("P", $utout + $p)
    assert_to_s("TRUE", $p + ~$p)
    assert_to_s("TRUE", ~$p + $p)

    assert_to_s("P", $p * $tout)
    assert_to_s("P", $tout * $p)
    assert_to_s("FALSE", $p * $utout)
    assert_to_s("FALSE", $utout * $p)
    assert_to_s("FALSE", $p * ~$p)
    assert_to_s("FALSE", ~$p * $p)
  end

  def test_basis
    assert_to_s("P", $p)
    assert_to_s("(P|Q)", $p + $q)
    assert_to_s("(P&Q)", $p * $q)
    assert_to_s("~P", ~$p)
    assert_to_s("(~P|Q)", $p >= $q)
    assert_to_s("((~P|Q)&(~Q|P))", $p <=> $q)
  end

  def test_main
    assert_to_s("(~P&~Q)", ~($p + $q))
    assert_to_s("(~P|~Q)", ~($p * $q))
    assert_to_s("P", ~(~$p))
    assert_to_s("((Q|P)&(R|P))", $p + ($q * $r))
    assert_to_s("(P&Q&R)", $p * ($q * $r))
    assert_to_s("(P&(~P|Q))", $p * ($p >= $q))
  end

  def test_tautology
    assert_to_s("TRUE", ($p * ($p >= $q)) >= $q)
    assert_to_s("TRUE", (($p >= $q) * ($q >= $r)) >= ($p >= $r))
    assert_to_s("TRUE", (~$p * ($p + $q)) >= ($q))
    assert_to_s("TRUE", (($p >= $q) * ($q >= $r) * $p) >= ($r))
  end

  def test_no_tautology
    assert_to_s("FALSE", $p * $q * ~$p)
  end
end
