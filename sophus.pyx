# -*- coding: utf-8 -*-
cimport sophus_defs as cpp
from sophus_defs cimport SO3 as _SO3
from sophus_defs cimport SE3 as _SE3
from eigency.core cimport *
from cython.operator cimport dereference as deref

ctypedef _SO3[double] _SO3d # double precision SO3 
ctypedef _SO3[float] _SO3f  # single precision SO3 
ctypedef _SE3[double] _SE3d # double precision SE3 
ctypedef _SE3[float] _SE3f  # single precision SE3 

cdef class SO3:
    cdef _SO3d *thisptr

    # Constructor, copy constructor, and construct from numpy array
    def __cinit__(self, other=None):
        cdef SO3 ostr
        if other is not None and type(other) is SO3:
            # print "SO3 Copy constructor"
            ostr = <SO3> other
            self.thisptr = new _SO3d(deref(ostr.thisptr))
        elif other is not None and type(other) is np.ndarray:
            # print "Init SO3 from ndarray"
            self.thisptr = new _SO3d(Map[Matrix3d](other))
        else:
            # print "Init empty SO3"
            self.thisptr = new _SO3d()


    def __dealloc__(self):
        del self.thisptr

    def matrix(self):
        return ndarray(self.thisptr.matrix())

    def log(self):
        return ndarray(self.thisptr.log())

    @staticmethod
    def exp(np.ndarray arr):
        """
        Computes the exponential map of a 3x1 so3 element
        """
        res = SO3()
        res.thisptr = new _SO3d(_SO3d.exp(Map[Vector3d](arr)))
        return res

cdef class SE3:
    cdef _SE3d *thisptr

    def __cinit__(self, other=None):
        cdef SE3 ostr
        if other is not None and type(other) is SE3:
            # print "SE3 Copy constructor"
            ostr = <SE3> other
            self.thisptr = new _SE3d(deref(ostr.thisptr))
        elif other is not None and type(other) is np.ndarray:
            # print "Init SE3 from ndarray"
            self.thisptr = new _SE3d(Map[Matrix4d](other))
        else:
            # print "Init empty SE3"
            self.thisptr = new _SE3d()

    def __dealloc__(self):
        del self.thisptr

    def matrix(self):
        return ndarray(self.thisptr.matrix())

    def translation(self):
        return ndarray(self.thisptr.translation())

    def so3(self):
        """
        Returns the SO3 part (rotation)
        """
        return SO3(ndarray(self.thisptr.so3().matrix())) 

    def log(self):
        return ndarray(self.thisptr.log())

    @staticmethod
    def exp(np.ndarray arr):
        """
        Computes the exponential map of a 6x1 se3 element
        """
        res = SE3()
        res.thisptr = new _SE3d(_SE3d.exp(Map[VectorXd](arr)))
        return res
