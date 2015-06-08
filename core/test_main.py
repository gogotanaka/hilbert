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

    # SYM
    def test_sym_plus2(self):
        h_parser.parser.parse('x+y')
        check(self, 'x + y')

    def test_sym_minus2(self):
        h_parser.parser.parse('x-y')
        check(self, 'x - y')

    def test_sym_multi2(self):
        h_parser.parser.parse('xy')
        check(self, 'x*y')

    def test_sym_div2(self):
        h_parser.parser.parse('x/y')
        check(self, 'x/y')

    def test_func_basis(self):
        h_parser.parser.parse('f(x) = x * x')
        h_parser.parser.parse('f(3)')
        check(self, '9')

    def test_diff1(self):
        h_eval('2*x', 'd/dx(x * x)', self)

    def test_inte1(self):
        h_eval('x**2/2', 'S(x dx)', self)

    def test_build_in_func1(self):
        h_eval('x**2/2', 'cos(x)', self)

    def tearDown(self):
        sys.stdout = sys.__stdout__

if __name__ == '__main__': unittest.main()
