# Author: Artyom Danilov

# Last Modification: 05 March, 2020.

# NOTE: PYTHONSTARTUP environment variable must be set.

# To explore memory
from sys import getrefcount as refcount
from sys import getsizeof as sizeof

# To explore python compilation
from dis import dis
disassemble = dis
from py_compile import compile

# To check the execution time of code
from timeit import timeit

# To print long datasets
from pprint import pprint

# To explore python keywords
from keyword import iskeyword, kwlist

# To explore python objects
from inspect import (signature, ismodule, isclass, isfunction,
                     isbuiltin, getsource)

# To explore how coping works
from copy import copy, deepcopy

try:
    from school import *
except ImportError:
    print("\n\tError: unable to load 'school' module.\n")

try:
    from interact import *
except ImportError:
    print("\n\tError: unable to load 'interact' module.\n")
