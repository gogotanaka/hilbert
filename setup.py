#!/usr/bin/env python

import os
import sys
from glob import glob

sys.path.insert(0, os.path.abspath('lib'))
from hilbert import __version__, __author__
from setuptools import setup, find_packages
# try:
#     from setuptools import setup, find_packages
# except ImportError:
#     print("Ansible now needs setuptools in order to build. Install it using"
#             " your package manager (usually python-setuptools) or via pip (pip"
#             " install setuptools).")
#     sys.exit(1)

setup(name='hilbert',
      version=__version__,
      description='Enjoy mathematics with keyboard instead of pen and paper',
      author=__author__,
      author_email='mail@tanakakazuki.com',
      url='http://hilbert-lang.org/',
      license='MIT',
      install_requires=['sympy', 'pycrypto >= 2.6', 'ply'],
      package_dir={ '': 'lib' },
      packages=find_packages('lib'),
    #   package_data={
    #      '': ['module_utils/*.ps1', 'modules/core/windows/*.ps1', 'modules/extras/windows/*.ps1'],
    #   },
      scripts=[
         'bin/hilbert'
      ],
      data_files=[],
)
