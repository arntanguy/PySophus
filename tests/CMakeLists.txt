add_test(NAME TestPySophus COMMAND ${CMAKE_SOURCE_DIR}/tests/test_pysophus.py)
message("Sophus dir: ${CMAKE_BINARY_DIR}/src")
message("Python path: $ENV{PYTHONPATH}")
set_tests_properties(TestPySophus
  PROPERTIES ENVIRONMENT "PYTHONPATH=$ENV{PYTHONPATH}:${CMAKE_BINARY_DIR}/src")
