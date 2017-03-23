# -*- coding: utf-8 -*-
cimport sophus_defs as cpp
from sophus_defs cimport SO3 as _SO3
from sophus_defs cimport SE3 as _SE3
from eigency.core cimport *
from cython.operator cimport dereference as deref
import numpy

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

    def inverse(self):
        res = SO3()
        res.thisptr = new _SO3d(self.thisptr.inverse()) 
        return res

    def normalize(self):
        self.thisptr.normalize()

    def __mul__(SO3 x, SO3 y):
        """
        Group multiplication operator
        """
        res = SO3()
        res.thisptr[0] = x.thisptr.mul(deref(y.thisptr))
        return res

    def __imul__(self, SO3 y):
        """
        In place group multiplication
        a *= b is the same as a = a*b
        """
        self.thisptr[0] = self.thisptr.mul(deref(y.thisptr))
        return self

    def __str__(self):
        return numpy.array_str(self.matrix())

    @staticmethod
    def exp(np.ndarray arr):
        """
        Computes the exponential map of a 3x1 so3 element
        """
        res = SO3()
        res.thisptr = new _SO3d(_SO3d.exp(Map[Vector3d](arr)))
        return res

    @staticmethod
    def generator(int i):
        return ndarray(_SO3d.generator(i))

    @staticmethod
    def hat(np.ndarray tangent):
        return ndarray(_SO3d.hat(Map[Vector3d](tangent)))

    @staticmethod
    def vee(np.ndarray transformation):
        return ndarray(_SO3d.vee(Map[Matrix3d](transformation)))

    @staticmethod
    def rotX(scalar):
        res = SO3()
        res.thisptr = new _SO3d(_SO3d.rotX(scalar))
        return res
    @staticmethod
    def rotY(scalar):
        res = SO3()
        res.thisptr = new _SO3d(_SO3d.rotY(scalar))
        return res
    @staticmethod
    def rotZ(scalar):
        res = SO3()
        res.thisptr = new _SO3d(_SO3d.rotZ(scalar))
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

    def inverse(self):
        res = SE3()
        res.thisptr = new _SE3d(self.thisptr.inverse()) 
        return res

    def normalize(self):
        self.thisptr.normalize()

    def rotationMatrix(self):
        return ndarray(self.thisptr.so3().matrix())

    def setRotationMatrix(self, np.ndarray matrix):
        self.thisptr.setRotationMatrix(Map[Matrix3d](matrix))

    def __mul__(SE3 x, SE3 y):
        """
        Group multiplication operator
        """
        res = SE3()
        res.thisptr[0] = x.thisptr.mul(deref(y.thisptr))
        return res

    def __imul__(self, SE3 y):
        """
        In place group multiplication
        a *= b is the same as a = a*b
        """
        self.thisptr[0] = self.thisptr.mul(deref(y.thisptr))
        return self

    def __str__(self):
        return numpy.array_str(self.matrix())

    @staticmethod
    def exp(np.ndarray arr):
        """
        Computes the exponential map of a 6x1 se3 element
        """
        res = SE3()
        res.thisptr = new _SE3d(_SE3d.exp(Map[VectorXd](arr)))
        return res
    @staticmethod
    def generator(int i):
        return ndarray(_SE3d.generator(i))
    @staticmethod
    def hat(np.ndarray tangent):
        return ndarray(_SE3d.hat(Map[VectorXd](tangent)))

    @staticmethod
    def vee(np.ndarray transformation):
        return ndarray(_SE3d.vee(Map[Matrix4d](transformation)))

    @staticmethod
    def rotX(scalar):
        res = SE3()
        res.thisptr = new _SE3d(_SE3d.rotX(scalar))
        return res
    @staticmethod
    def rotY(scalar):
        res = SE3()
        res.thisptr = new _SE3d(_SE3d.rotY(scalar))
        return res
    @staticmethod
    def rotZ(scalar):
        res = SE3()
        res.thisptr = new _SE3d(_SE3d.rotZ(scalar))
        return res
    @staticmethod
    def trans(x, y, z):
        res = SE3()
        res.thisptr = new _SE3d(_SE3d.trans(x,y,z))
        return res
