mkdir build
cd build
rem set LINK_DIRECTORIES=%IFortInstallDir%compiler\lib\Intel64_win
rem del CMakeCache.txt
cmake -S .. -B . > log.cmake.txt 2>&1
cmake --build . --config %1 > log.make.txt 2>&1

rem run
rem set PATH=%IFORT_COMPILER19%redist\intel64_win\compiler\;%PATH%
%1\testc.exe
