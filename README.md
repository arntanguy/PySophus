PySophus
======

Overview
--------

**PySophus** defines python bindings for [Sophus](https://github.com/strasdat/Sophus) library.

> Sophus is a c++ implementation of Lie oproups commonly used for 2d and 3d
> geometric problems (i.e. for Computer Vision or Robotics applications).
> Among others, this package includes the special orthogonal groups SO(2) and
> SO(3) to present rotations in 2d and 3d as well as the special Euclidean group
> SE(2) and SE(3) to represent rigid body transformations (i.e. rotations and
> translations) in 2d and 3d.

Dependencies
------------

This package uses:
- [eigency](https://github.com/wouterboomsma/eigency) For basic Eigen support.
- [Sophus](https://github.com/strasdat/Sophus) for Lie algebra support.

Supported operations
--------------------
*Updated on 21/03/2017*

So far, only basic operations are supported:
- `SE3`, `SO3` representation
- log, exp, and basic convenience functions

How to install
--------------

First, setup `eigency`

```
git clone https://github.com/wouterboomsma/eigency.git
cd eigency
python setup.py build_ext --inplace
# put in your bashrc
export PYTHONPATH="$PYTHONPATH:<path to eigency>"
```

Then, clone this repository, and run

```
git clone https://github.com/arntanguy/PySophus.git
cd PySophus
git submodule init
git submodule update
python setup.py build_ext --inplace
# put in your bashrc
export PYTHONPATH="$PYTHONPATH:<path to PySophus>"
```

Usage
-----

Python usage is transparent, the naming convention of Sophus is kept for the bindings

```python
from sophus import *
import numpy as np

T = SE3()
t = T.log()
T = SE3.exp(t)
R = T.so3()
r = R.log()
R = SO3.exp(r)

numpy_mat = T.matrix()
numpy_mat[0,3] = 2;
T = SE3(numpy_mat)
T.log()

x = np.array([1,0,0,0,0,0]).T
T = SE3.exp(x)
```
