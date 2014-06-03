cmake_minimum_required(VERSION 2.8.8)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)

#
# Dashboard properties
#
set(HOSTNAME              "factory-south-win7")
set(MY_COMPILER           "VS2008")
set(CTEST_DASHBOARD_ROOT  "C:/D/P")
# Open a shell and type in "cmake --help" to obtain the proper spelling of the generator
set(CTEST_CMAKE_GENERATOR "Visual Studio 9 2008 Win64")
set(MY_BITNESS            "64")

set(package_version 431)
set(SVN_BRANCH "branches/Slicer-4-3")
set(SVN_REVISION "22599") # Release 4.3.1
set(MY_QT_VERSION "4.7.4")

#
# Dashboard options
#
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(WITH_PACKAGES TRUE)
set(run_ctest_with_update FALSE)
set(WITH_EXTENSIONS FALSE) # Indicates if 'trusted' Slicer extensions should be
                          # built, tested, packaged and uploaded.
set(CTEST_BUILD_CONFIGURATION "Release")

set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicer_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

set(SCRIPT_MODE "experimental") # "experimental", "continuous", "nightly"

# Additional CMakeCache options
# For example:
#   ADDITIONAL_{C/CXX}_FLAGS: /MP -> Multi process build with MSVC
#
set(ADDITIONAL_CMAKECACHE_OPTION "
  ADDITIONAL_C_FLAGS:STRING=/MP
  ADDITIONAL_CXX_FLAGS:STRING=/MP
  Slicer_USE_PYTHONQT:BOOL=ON
  Slicer_USE_PYTHONQT_WITH_TCL:BOOL=ON
  Slicer_BUILD_CLI:BOOL=ON
  Slicer_USE_VTK_DEBUG_LEAKS:BOOL=OFF
  Slicer_BUILD_WIN32_CONSOLE:BOOL=OFF
  Slicer_PATCH_VERSION:STRING=0
  Slicer_USE_SimpleITK:BOOL=ON
  Slicer_USE_PYTHONQT_WITH_OPENSSL:BOOL=ON
")
set(BUILD_OPTIONS_STRING "${MY_BITNESS}bits")
#
# Project specific properties
#
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer-${package_version}-1")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer-${package_version}-package-1")
file(WRITE "${CTEST_DASHBOARD_ROOT}/Slicer-${package_version}-package-1 - Slicer-${package_version}-build-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE}.txt" "Generated by ${CTEST_SCRIPT_NAME}")
# List of test that should be explicitly disabled on this machine
set(TEST_TO_EXCLUDE_REGEX "qMRMLLayoutManagerTest3")
# set any extra environment variables here
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()
##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################
set(CTEST_NOTES_FILES "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")
#
# Project specific properties
#
set(CTEST_PROJECT_NAME "Slicer4")
set(CTEST_BUILD_NAME "${MY_OPERATING_SYSTEM}-${MY_COMPILER}-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}")
#
# Display build info
#
message("site name: ${CTEST_SITE}")
message("build name: ${CTEST_BUILD_NAME}")
message("script mode: ${SCRIPT_MODE}")
message("coverage: ${WITH_COVERAGE}, memcheck: ${WITH_MEMCHECK}")
 
#
# Download and include dashboard driver script
#
set(url http://svn.slicer.org/Slicer4/${SVN_BRANCH}/CMake/SlicerDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
INCLUDE(${dest})
