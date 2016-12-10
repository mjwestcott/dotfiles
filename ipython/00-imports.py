from collections import deque, defaultdict, namedtuple
from math import log, sqrt, floor, ceil, pi, e
import datetime, time
import re, sys, os
import random

try:
    from math import log2
except ImportError:
    def log2(x):
        return log(x, 2)

try:
    from math import inf
except ImportError:
    inf = float('inf')

try:
    import numpy as np
except ImportError:
    pass

try:
    import pandas as pd
except ImportError:
    pass

try:
    import tensorflow as tf
except ImportError:
    pass
