cmake_minimum_required(VERSION 2.8.6)
project(fortranc Fortran CXX)

#set Fortran static runtime linking
set(CMAKE_Fortran_FLAGS "/threads /libs:static /MT")

add_library(TWICE_dll ../../TWICE_dll.f90)
add_executable(TWICE_call_cpp ../../TWICE_call_cpp.cpp)
target_link_libraries(TWICE_call_cpp TWICE_dll)
