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
    'cirq', 'coverage', 'django', 'fastai', 'gevent', 'gym', 'h5py', 'horovod',
    'IPython', 'joblib', 'matplotlib', 'mlflow', 'mpi4py', 'nltk', 'numpy',
    'pandas', 'pycurl', 'pyls', 'pyqtgraph', 'qiskit', 'qutip', 'seaborn',
    'scipy', 'selenium', 'skimage', 'sklearn', 'sympy', 'tables',
    'tensorboardX', 'tensorflow', 'tensorflow_probability', 'tf_agents',
    'torch', 'torchvision', 'tornado', 'xgboost', 'xacc', 'xlrd', 'yaml',
]

for mod in modules:
    test_module_version(mod)
