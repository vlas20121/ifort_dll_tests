rem call "G:\PF\Intel\oneAPI\compiler\2021.1.2\env\vars.bat"
rem call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\vsdevcmd\ext\vcvars\vcvars140.bat" x64
rem set CMAKE_GENERATOR=Ninja
rem set CMAKE_Fortran_COMPILER=ifort

mkdir build
cd build

del CMakeCache.txt
cmake -S .. -B . > log.cmake.txt 2>&1
cmake --build . --config %1 > log.make.txt 2>&1
rem set PATH=%IFORT_COMPILER19%redist\intel64_win\compiler\;%PATH%
.\%1\helloworld.exe