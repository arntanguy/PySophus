import unittest
from sophus import *
import numpy as np
import math

class LayoutOrderTest(unittest.TestCase):
    def setUp(self):
        print "Running LayoutOrderTest"

    def test(self):
        angle = math.pi/4;
        T1 = SE3.rotX(angle)
        T1_numpy = T1.matrix();
        T2_numpy = np.array([[1, 0, 0, 0],
                             [0, math.cos(angle), -math.sin(angle), 0],
                             [0, math.sin(angle), math.cos(angle), 0],
                             [0, 0, 0, 1]])
        
        # print(np.allclose(T1_numpy,T2_numpy)) #result is "true"
        # print(SE3(T1_numpy))
        # print(SE3(T2_numpy))
        T1 = SE3(T1_numpy)
        T2 = SE3(T2_numpy)
        self.assertTrue(np.allclose(T1.matrix(), T2.matrix()))


if __name__ == '__main__':
    unittest.main()
