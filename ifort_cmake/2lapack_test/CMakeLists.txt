cmake_minimum_required(VERSION 2.8)
project(fortranc)
include(CMakeAddFortranSubdirectory)

#set Fortran static runtime linking
set(CMAKE_Fortran_FLAGS "/threads /libs:static /MT")

# add the lapack subdirectory as a fortran project
# the subdir is lapack, the project is LAPACK
cmake_add_fortran_subdirectory(lapack
  PROJECT LAPACK  # project name in toplevel CMakeLists.txt in lapack
  ARCHIVE_DIR lapack/lib # .lib location relative to root binary tree
  RUNTIME_DIR lapack/bin # .dll location relative to root binary tree
  LIBRARIES blas lapack # target libraries created
  LINK_LIBRARIES  # link interface libraries
   LINK_LIBS lapack blas # lapack needs blas to link
  NO_EXTERNAL_INSTALL
  )
#LINK_DIRECTORIES($ENV{LINK_DIRECTORIES})
#LINK_DIRECTORIES($ENV{IFORT_COMPILER19}redist/intel64_win/compiler)
LINK_DIRECTORIES($ENV{IFORT_COMPILER19}compiler/lib/Intel64_win)

add_executable(testc test.c)
target_link_libraries(testc lapack)

