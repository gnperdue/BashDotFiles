#!/usr/bin/env python
from __future__ import print_function

import sys
import importlib

print('Python version: {}'.format(sys.version))


def test_module_version(module_name):
    try:
        mod = importlib.import_module(module_name)
        print('{} version: {}'.format(module_name, mod.__version__))
    except ImportError:
        print('Missing {}'.format(module_name))
    except Exception as e:
        print('Possible problem with module: {}, {}'.format(
            module_name, e
        ))

modules = [
    'pandas', 'matplotlib', 'numpy', 'scipy', 'IPython', 'sklearn',
    'skimage', 'protobuf', 'numexpr', 'sympy', 'tensorflow', 'pymc3',
    'theano', 'carl', 'h5py', 'keras', 'xlrd', 'lasagne'
]

for mod in modules:
    test_module_version(mod)

print("Note, Keras configuration is in $HOME/.keras/keras.json")
