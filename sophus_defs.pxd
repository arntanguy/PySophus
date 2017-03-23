# -*- coding: utf-8 -*-
from eigency.core cimport *



cdef extern from "<sophus/so3.hpp>" namespace "Sophus":
  cdef cppclass SO3[Scalar]:
      SO3() except +
      # copy constructor
      SO3(const SO3&) except +
      SO3(const Map[Matrix3d]&) except +

      Matrix3d& matrix()

      Vector3d log()

      SO3 inverse()
      void normalize()

      SO3 mul "operator*"(const SO3&)
      SO3 mul_assign "operator*="(const SO3&)


      @staticmethod
      SO3[Scalar] exp(const Map[Vector3d]&)
      @staticmethod
      Matrix3d generator(int i)
      @staticmethod
      Matrix3d hat(const Map[Vector3d]&)
      @staticmethod
      Vector3d vee(const Map[Matrix3d]&)
      @staticmethod
      SO3 rotX(const Scalar&)
      @staticmethod
      SO3 rotY(const Scalar&)
      @staticmethod
      SO3 rotZ(const Scalar&)
      

cdef extern from "<sophus/se3.hpp>" namespace "Sophus":
  cdef cppclass SE3[Scalar]:
    SE3() except +
    SE3(const SE3&) except +
    SE3(const Map[Matrix4d] &mat) except +

    Matrix4d& matrix()
    Vector3d translation()
    SO3 so3()
        
    VectorXd log()

    SE3 inverse()
    void normalize()

    Matrix4d rotationMatrix()
    void setRotationMatrix(const Map[Matrix3d]&)

    SE3 mul "operator*"(const SE3&)
    SE3 mul_assign "operator*="(const SE3&)
    @staticmethod
    SE3[Scalar] exp(const Map[VectorXd]&)
    @staticmethod
    Matrix4d generator(int i)
    @staticmethod
    Matrix4d hat(const Map[VectorXd]&)
    @staticmethod
    VectorXd vee(const Map[Matrix4d]&)

    # Single axis factories
    @staticmethod
    SE3 trans(const Scalar&, const Scalar&, const Scalar&)
    @staticmethod
    SE3 transX(const Scalar&)
    @staticmethod
    SE3 transY(const Scalar&)
    @staticmethod
    SE3 transZ(const Scalar&)
    @staticmethod
    SE3 rotX(const Scalar&)
    @staticmethod
    SE3 rotY(const Scalar&)
    @staticmethod
    SE3 rotZ(const Scalar&)
