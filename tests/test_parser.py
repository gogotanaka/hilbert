import sys
import os
from io import StringIO

sys.path.insert(0, os.path.abspath('src'))
from hilbert.CalcExecuter import CalcExecuter

executer = CalcExecuter()

def assert_equal(input, output):
    io = StringIO()
    sys.stdout = io
    executer.call(input)
    sys.stdout = sys.__stdout__
    assert io.getvalue().replace("\n", "") == output

def clear():
    global executer
    executer = CalcExecuter()

def test_basis():
    assert_equal('a', 'a')
    assert_equal('b', 'b')
    assert_equal('5c', '5c')
    assert_equal('5c+b', 'b + 5c')
    assert_equal('2', '2')
    assert_equal('1+2', '3')
    assert_equal('1-2', '-1')
    assert_equal('1*2', '2')
    assert_equal('1/2', '0.5')
    assert_equal('2 ^ 3', '8')
    assert_equal('2x', '2x')
    assert_equal('xxxxyyyxxzz', '(x^6)(y^3)(z^2)')
    executer.call('a=1')
    assert_equal('a', '1')
    clear()
    assert_equal('a', 'a')
    executer.call('a=2')
    executer.call('b=3')
    assert_equal('a+b', '5')
    assert_equal('a-b', '-1')
    assert_equal('a*b', '6')
    assert_equal('ab', '6')
    assert_equal('a/b', '0.6666666666666666')

    executer.call('c=23')
    executer.call('k=34')
    executer.call('j=2')
    assert_equal('ckj', '1564')

def test_func1():
    executer.call("f(x) = x * x")
    assert_equal('f(3)', '9')
    assert_equal('f(y)', 'y^2')
    assert_equal('f(y/2)', 'y^2/4')

def test_func2():
    executer.call("f(x) = xxxx + x")
    assert_equal('f(2)', '18')
    assert_equal('f(y)', 'y^4 + y')
    # assert_equal('f(y/2)', 'y^(4/16) + y/2')

def test_func3():
    executer.call('f(x,y) = xy')
    assert_equal('f(3,2)', '6')
    assert_equal('f(s,t)', 'st')
    assert_equal('f(6,t)', '6t')
    assert_equal('f(s/2,t)', 'st/2')
    executer.call('t=2')
    assert_equal('f(6,t)', '12')

    executer.call('g(x,y,z) = xyz')
    assert_equal('g(3,2,3)', '18')

def test_constants():
    assert_equal('e', 'e')
    assert_equal('pi', 'pi')
    assert_equal('sin(pi)', '0')
    assert_equal('oo', 'oo')
    assert_equal('e/oo', '0')
    assert_equal('oo - oo', 'nan')
    assert_equal('sin(oo)', 'AccumBounds(-1, 1)')
    assert_equal('e^oo', 'oo')
    assert_equal('(1/pi)^oo', '0')
    assert_equal('e^3', 'e^3')
    assert_equal('e^x', 'e^x')
    assert_equal('d/dx(e^x)', 'e^x')
    assert_equal('i = 1', "Can't assign new value on constant")
    assert_equal('e^(i*pi)', '-1')
    assert_equal('i^2', '-1')

def test_diff():
    assert_equal('d/dx(x * x)', '2x')
    assert_equal('d/dy(x * x)', '0')
    assert_equal('d/dx(xxy)', '2xy')

    executer.call('f(x)=xxxxxxx')
    assert_equal('df/dx', '7(x^6)')

def test_intg():
    assert_equal('S(x dx)', 'x^2/2')
    assert_equal('S(cos(x) dx)', 'sin(x)')
    assert_equal('d/dx(S(cos(x) dx))', 'cos(x)')
    executer.call('f(x)=xxxxxxx')
    assert_equal('S(f dx)', 'x^8/8')

def test_limit():
    assert_equal('lim[x->1](x)', '1')
    assert_equal('lim[x->1](1/x)', '1')
    assert_equal('lim[x->oo](1/x)', '0')

def test_buildin_func():
    assert_equal('cos(x)', 'cos(x)')
    assert_equal('d/dx(cos(x))', '-sin(x)')
    assert_equal('d/dy(cos(x))', '0')
    assert_equal('cos(1)', 'cos(1)')