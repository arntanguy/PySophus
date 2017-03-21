# -*- coding: utf-8 -*-
from eigency.core cimport *



cdef extern from "<sophus/so3.hpp>" namespace "Sophus":
  cdef cppclass SO3[Scalar]:
      SO3() except +
      # copy constructor
      SO3(SO3&) except +
      SO3(Map[Matrix3d]&) except +

      Matrix3d& matrix()

      Vector3d log()

      @staticmethod
      SO3[Scalar] exp(Map[Vector3d]&)

cdef extern from "<sophus/se3.hpp>" namespace "Sophus":
  cdef cppclass SE3[Scalar]:
    SE3() except +
    SE3(SE3&) except +
    SE3(Map[Matrix4d] &mat) except +

    Matrix4d& matrix()
    Vector3d translation()
    SO3 so3()
        
    VectorXd log()
    @staticmethod
    SE3[Scalar] exp(Map[VectorXd]&)
