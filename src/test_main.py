import unittest
import h_parser
import io
import sys

def hAssertEqual(test_obj, output, input):
    h_parser.parser.parse(input)
    test_obj.assertEqual(sys.stdout.getvalue().replace("\n", ""), output)
    sys.stdout = sys.__stdout__
    sys.stdout = io.StringIO()


class TestMainMethods(unittest.TestCase):
    def setUp(self):
        sys.stdout = io.StringIO()

    def test_basis(self):
        hAssertEqual(self, 'a', 'a')
        hAssertEqual(self, 'b', 'b')
        hAssertEqual(self, '2', '2')
        hAssertEqual(self, '3', '1+2')
        hAssertEqual(self, '-1', '1-2')
        hAssertEqual(self, '2', '1*2')
        hAssertEqual(self, '0.5', '1/2')
        hAssertEqual(self, '8', '2 ^ 3')

        h_parser.parser.parse('a=1')
        hAssertEqual(self, '1', 'a')

        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        hAssertEqual(self, '5', 'a+b')
        hAssertEqual(self, '-1', 'a-b')
        hAssertEqual(self, '6', 'a*b')
        hAssertEqual(self, '6', 'ab')
        hAssertEqual(self, '0.6666666666666666', 'a/b')

        h_parser.parser.parse('c=23')
        h_parser.parser.parse('i=34')
        h_parser.parser.parse('j=2')
        hAssertEqual(self, '1564', 'cij')

        hAssertEqual(self, '2x', '2x')
        #h_eval('(x^6)(y^3)(z^2)', 'xxxxyyyxxzz', self)
        # hAssertEqual(self, )
        # hAssertEqual(self, )

    def test_func(self):
        h_parser.parser.parse("f(x) = x * x")
        hAssertEqual(self, '9', 'f(3)')
        # hAssertEqual(self, 'y^2', 'f(y)')

        h_parser.parser.parse('f(x,y) = xy')
        hAssertEqual(self, '6', 'f(3,2)')

        h_parser.parser.parse('g(x,y,z) = xyz')
        hAssertEqual(self, '18', 'g(3,2,3)')

    def test_diff(self):
        hAssertEqual(self, '2x', 'd/dx(x * x)')
        hAssertEqual(self, '0', 'd/dy(x * x)')
        hAssertEqual(self, '2xy', 'd/dx(xxy)')

    def test_intg(self):
        hAssertEqual(self, 'x^2/2', 'S(x dx)')
        hAssertEqual(self, 'sin(x)', 'S(cos(x) dx)')
        hAssertEqual(self, 'cos(x)', 'd/dx(S(cos(x) dx))')

    def test_buildin_func(self):
        hAssertEqual(self, 'cos(x)', 'cos(x)')
        hAssertEqual(self, '-sin(x)', 'd/dx(cos(x))')
        hAssertEqual(self, '0', 'd/dy(cos(x))')
        hAssertEqual(self, 'cos(1)', 'cos(1)')

    def test_constants(self):
        hAssertEqual(self, 'e', 'e')
        hAssertEqual(self, '3.141592653589793', 'pi')
        hAssertEqual(self, 'oo', 'oo')
        hAssertEqual(self, 'e^3', 'e^3')
        hAssertEqual(self, 'e^x', 'e^x')
        hAssertEqual(self, 'e^x', 'd/dx(e^x)')

    def test_limit(self):
        hAssertEqual(self, '1', 'lim[x->1](x)')
        hAssertEqual(self, '1', 'lim[x->1](1/x)')
        hAssertEqual(self, '0', 'lim[x->oo](1/x)')

    def tearDown(self):
        sys.stdout = sys.__stdout__

if __name__ == '__main__': unittest.main()
