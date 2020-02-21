# Author: Artyom Danilov

# Last Modification 21 February, 2020.

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

# Fast random generation
from random import randint, choice

try:
    from school import *
except ModuleNotFoundError:
    print("\n\tError: 'school' module not found.\n")


#def refcount(object_):
#    """
#        So that not to be confused by the increase of object's refcount
#        by passing the object as an argument to the 'getrefcount' function call
#    """
#    return getrefcount(object_) - 3

def ls():
    """ Prints the names defined in '__name__' module. """
    pprint(dir(sys.modules[__name__]))
