# If the pyx file is a C++ file, we should specify that here.
set_source_files_properties(
  ${CMAKE_SOURCE_DIR}/src/sophus_defs.pyx
  ${CMAKE_SOURCE_DIR}/src/sophus.pyx
  PROPERTIES CYTHON_IS_CXX TRUE )

# Multi-file cython modules do not appear to be working at the moment.
## XXX why?
include_directories(${EIGENCY_INCLUDE_DIR}/eigency)
cython_add_module( sophus sophus.pyx )
install (TARGETS sophus DESTINATION ${PYTHON_SITE_PACKAGES_INSTALL_DIR})
