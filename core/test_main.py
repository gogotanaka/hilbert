import unittest
import h_parser

try:
    import StringIO
except ImportError:
    import io as StringIO

import sys

def check(test_obj, expected):
    test_obj.assertEqual(sys.stdout.getvalue().replace("\n", ""), expected)

class TestMainMethods(unittest.TestCase):
    def setUp(self):
        sys.stdout = StringIO.StringIO()

    def test_ex1(self):
        print('d')
        check(self, 'd')

    def test_ex2(self):
        h_parser.parser.parse('2')
        check(self, '2')

    def test_var1(self):
        h_parser.parser.parse('a=1')
        h_parser.parser.parse('a')
        check(self, '1')

    def test_var2(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('a * b')
        check(self, '6')

    def test_var_multi1(self):
        h_parser.parser.parse('a=2')
        h_parser.parser.parse('b=3')
        h_parser.parser.parse('ab')
        check(self, '6')

    def test_var_multi1(self):
        h_parser.parser.parse('c=23')
        h_parser.parser.parse('d=34')
        h_parser.parser.parse('e=2')
        h_parser.parser.parse('cde')
        check(self, '1564')

    def tearDown(self):
        sys.stdout = sys.__stdout__

if __name__ == '__main__': unittest.main()
