# -*- coding: utf-8 -*-

from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
import eigency
print eigency.get_includes(include_eigen=False)
setup(
    ext_modules = cythonize([Extension("sophus", 
        sources=["sophus.pyx"],
        include_dirs = [".", "/usr/include/eigen3", "./Sophus"] + eigency.get_includes(include_eigen=False),
        language="c++",
        extra_compile_args=["-std=c++11"])])
)
