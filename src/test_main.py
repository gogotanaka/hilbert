import unittest
import h_parser

try:
    import StringIO
except ImportError:
    import io as StringIO

import sys

def check(test_obj, expected):
    test_obj.assertEqual(sys.stdout.getvalue().replace("\n", ""), expected)

def h_eval(output, input, test_obj):
    h_parser.parser.parse(input)
    check(test_obj, output)

class TestMainMethods(unittest.TestCase):
    def setUp(self):
        sys.stdout = StringIO.StringIO()

    def test_ex1(self):
        print('d')
        check(self, 'd')

    def test_ex2(self):
        h_eval('2', '2', self)

    def test_basis1(self):
        h_eval('8', '2 ^ 3', self)

    def test_var1(self):
        h_parser.parser.parse('a=1')
        h_parser.parser.parse('a')
        check(self, '1')

    def test_var2(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('a + b')
        check(self, '5')

    def test_var3(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('a - b')
        check(self, '-1')

    def test_var4(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('a * b')
        check(self, '6')

    def test_var5(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('a / b')
        check(self, '0.6666666666666666')

    def test_var_multi1(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('ab')
        check(self, '6')

    def test_var_multi2(self):
        h_parser.parser.parse('c=23')
        h_parser.parser.parse('i=34')
        h_parser.parser.parse('j=2')
        h_parser.parser.parse('cij')
        check(self, '1564')

    def test_var_multi3(self):
        h_eval('2x', '2x', self)

    def test_var_multi4(self):
        h_eval('(x^6)(y^3)(z^2)', 'xxxxyyyxxzz', self)

    # SYM
    def test_sym_plus2(self):
        h_parser.parser.parse('x+y')
        check(self, 'x + y')

    def test_sym_minus2(self):
        h_parser.parser.parse('x-y')
        check(self, 'x - y')

    def test_sym_multi2(self):
        h_parser.parser.parse('xy')
        check(self, 'xy')

    def test_sym_div2(self):
        h_parser.parser.parse('x/y')
        check(self, 'x/y')

    def test_func_basis(self):
        h_parser.parser.parse('f(x) = x * x')
        h_parser.parser.parse('f(3)')
        check(self, '9')

    def test_func_basis1(self):
        h_parser.parser.parse('f(x,y) = xy')
        h_parser.parser.parse('f(3,2)')
        check(self, '6')

    def test_func_basis2(self):
        h_parser.parser.parse('g(x,  y,  z) = xyz')
        h_parser.parser.parse('g(3,2,3)')
        check(self, '18')

    def test_diff1(self):          h_eval('2x', 'd/dx(x * x)', self)
    def test_diff2(self):          h_eval('0', 'd/dy(x * x)', self)
    def test_diff2(self):          h_eval('2xy', 'd/dx(xxy)', self)

    def test_inte1(self):          h_eval('x^2/2', 'S(x dx)', self)
    def test_inte2(self):          h_eval('sin(x)', 'S(cos(x) dx)', self)
    def test_inte3(self):          h_eval('cos(x)', 'd/dx(S(cos(x) dx))', self)

    def test_build_in_func1(self): h_eval('cos(x)',  'cos(x)',       self)
    def test_build_in_func2(self): h_eval('-sin(x)', 'd/dx(cos(x))', self)
    def test_build_in_func3(self): h_eval('0',       'd/dy(cos(x))', self)
    def test_build_in_func4(self): h_eval('cos(1)',  'cos(1)',       self)

    def test_constants1(self): h_eval('2.718281828459045',  'e',  self)
    def test_constants2(self): h_eval('3.141592653589793', 'pi', self)
    def test_constants3(self): h_eval('oo', 'oo', self)


    def tearDown(self):
        sys.stdout = sys.__stdout__

if __name__ == '__main__': unittest.main()
