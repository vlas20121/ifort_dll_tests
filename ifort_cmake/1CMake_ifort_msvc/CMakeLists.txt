cmake_minimum_required(VERSION 3.15)
enable_language (Fortran)
project(helloworld)

#set Fortran static runtime linking
set(CMAKE_Fortran_FLAGS "/threads /libs:static /MT")

set(CMAKE_INCLUDE_CURRENT_DIR ON)
file(GLOB src "*.f90")
add_executable(${PROJECT_NAME} ${src})
