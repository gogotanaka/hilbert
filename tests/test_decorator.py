import sys
import os
from io import StringIO

sys.path.insert(0, os.path.abspath('src'))
import hilbert.decorator as decorator

def assert_equal(input, output):
    assert decorator.call(input) == output

def test_basis():
    assert_equal('y**2', 'y^2')
    assert_equal('exp(1)', 'e')
    assert_equal('s*t/2', 'st/2')

