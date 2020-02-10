# Author: Artyom Danilov

# Last Modification 10 February, 2020.

# NOTE: PYTHONSTARTUP environment variable must be set.

from sys import getrefcount
from sys import getsizeof as sizeof

from dis import dis
disassemble = dis

from inspect import signature, ismodule, isclass, isfunction, isbuiltin

try:
    from school import *
except ModuleNotFoundError:
    print("\n\tError: 'school' module not found.\n")


def refcount(object_):
    """
        So that not to be confused by the increase of object's refcount
        by passing the object as an argument to the 'getrefcount' function call
    """
    return getrefcount(object_) - 3
