require 'minitest_helper'

class TestFunction < TestInterpreterBase
  def setup

  end

  def test_general
    assert_def_func('f(x, y) = x + y', 'x + y')
    assert_cal_func('f( 4, 5 )', '9.0')

    assert_def_func('f( x     ,    y) = xy', 'x * y')
    assert_cal_func('f( 3, 9 )', '27.0')

    assert_def_func('f(x, y) = xy^2', 'x * ( y ** 2 )')
    assert_cal_func('f( 3, 2 )', '12.0')

    assert_def_func('f(x, y) = xy^2', 'x * ( y ** 2 )')
    assert_cal_func('df/dx', 'y ^ 2')

    assert_def_func('g(x) = x ^ 2', 'x ** 2')
    assert_cal_func('g(2)', '4.0')

    assert_def_func('h(x) = e ^ 2', 'e ** 2')
    assert_cal_func('h(2)', '7.3890560989306495')

    assert_def_func('h(x) = pix', 'pi * x')
    assert_cal_func('h(3)', '9.42477796076938')

    assert_def_func('h(x) = pie', 'pi * e')
    assert_cal_func('h(2)', '8.539734222673566')

    assert_def_func('h(x) = ( 1 / ( 2pi ) ^ ( 1 / 2.0 ) ) * e ^ ( - x ^ 2 / 2 )', '( ( 4503599627370496 / 6369051672525773 ) / ( pi ** 0.5 ) ) * ( e ** ( ( - ( x ** 2 ) ) / 2 ) )')
    assert_cal_func('S( h(x)dx )[-oo..oo]', '1.0')

    assert_def_func('f(x) = sin(x)', 'sin( x )')
    assert_cal_func('f(pi)', '0.0')

    assert_def_func('f(x) = cos(x)', 'cos( x )')
    assert_cal_func('f(pi)', '-1.0')

    assert_def_func('f(x) = log(x)', 'log( x )')
    assert_cal_func('f(e)', '1.0')
  end
end
