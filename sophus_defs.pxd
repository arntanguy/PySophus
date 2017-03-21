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

      SO3 inverse()
      void normalize()

      SO3 mul "operator*"(SO3)
      SO3 mul_assign "operator*="(SO3)


      @staticmethod
      SO3[Scalar] exp(Map[Vector3d]&)
      @staticmethod
      Matrix3d generator(int i)
      @staticmethod
      Matrix3d hat(Map[Vector3d]&)
      @staticmethod
      Vector3d vee(Map[Matrix3d]&)
      

cdef extern from "<sophus/se3.hpp>" namespace "Sophus":
  cdef cppclass SE3[Scalar]:
    SE3() except +
    SE3(SE3&) except +
    SE3(Map[Matrix4d] &mat) except +
    # SE3(Map[Matrix3d] &rot, Map[Vector3d]& trans) except +

    Matrix4d& matrix()
    Vector3d translation()
    SO3 so3()
        
    VectorXd log()

    SE3 inverse()
    void normalize()

    Matrix4d rotationMatrix()
    void setRotationMatrix(Map[Matrix3d]&)

    SE3 mul "operator*"(SE3)
    SE3 mul_assign "operator*="(SE3)
    @staticmethod
    SE3[Scalar] exp(Map[VectorXd]&)
    @staticmethod
    Matrix4d generator(int i)
    @staticmethod
    Matrix4d hat(Map[VectorXd]&)
    @staticmethod
    VectorXd vee(Map[Matrix4d]&)
