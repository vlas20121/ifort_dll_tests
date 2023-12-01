mkdir build
cd build

rem del CMakeCache.txt
cmake -S .. -B . > log.cmake.txt 2>&1
cmake --build . --config %1 > log.make.txt 2>&1
rem set PATH=%IFORT_COMPILER19%redist\intel64_win\compiler\;%PATH%
%1\TWICE_call_cpp.exe