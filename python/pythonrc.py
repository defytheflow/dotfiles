#!/usr/bin/python3

print('Running .pythonrc')

# -----------------------------------------------------------------------------
#                             _   _
#                 _ __  _   _| |_| |__   ___  _ __  _ __ ___
#                | '_ \| | | | __| '_ \ / _ \| '_ \| '__/ __|
#                | |_) | |_| | |_| | | | (_) | | | | | | (__
#                | .__/ \__, |\__|_| |_|\___/|_| |_|_|  \___|
#                |_|    |___/
#
# ----------------------------------------------------------------------------
#  File: .pythonrc
# ----------------------------------------------------------------------------
#  Modified: March 19, 2020
# ----------------------------------------------------------------------------
#  Author: Artyom Danilov
# ----------------------------------------------------------------------------
# NOTE: PYTHONSTARTUP environment variable must be set.
# ----------------------------------------------------------------------------

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
