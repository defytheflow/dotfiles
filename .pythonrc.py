# By Artyom Danilov
# Last Modification 29 January, 2020.
# NOTE: PYTHONSTARTUP environment variable must be set.

from sys import getrefcount
from sys import getsizeof as sizeof

from dis import dis as disassemble
dis = disassemble

from inspect import signature

def refcount(object_):
    """
        So that not to be confused by the increase of object's refcount
        by passing the object as an argument to the 'getrefcount' function call
    """
    return getrefcount(object_) - 3
