import unittest
import h_parser

try:
    import StringIO
except ImportError:
    import io as StringIO

import sys

class TestMainMethods(unittest.TestCase):
    def setUp(self):
        sys.stdout = StringIO.StringIO()

    def test_ex1(self):
        print('d')
        result = sys.stdout.getvalue()
        self.assertEqual(result, 'd\n')

    def test_ex2(self):
        h_parser.parser.parse('2')
        result = sys.stdout.getvalue()
        self.assertEqual(result, '2\n')

    def tearDown(self):
        sys.stdout = sys.__stdout__

if __name__ == '__main__': unittest.main()
