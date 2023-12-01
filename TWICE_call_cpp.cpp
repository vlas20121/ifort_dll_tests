// TWICE_call_cpp.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>

#pragma pack(push, 1)
class COMPLEX8
{
public:
    COMPLEX8(float _r, float _i):r(_r), i(_i) {}
    void print(const char* s)
    {
        std::cout << s << "COMPLEX8(" << r << "," << i << ")\n";
    }
    float r, i;
};
#pragma pack(pop)
extern "C" void TWICE(int& x, int& y);              //TWICE(X,Y);INTEGER :: X;INTEGER :: Y;
extern "C" void DOUBLE_ARRAY1(double* a, const int& n);   //DOUBLE_ARRAY1(a, n);INTEGER INTENT(IN) :: n; REAL*8 , INTENT(INOUT) :: a(n)
extern "C" void DOUBLE_ARRAY2(double* a, const int& n);   //DOUBLE_ARRAY1(a, n);INTEGER INTENT(IN) :: n; REAL*8 , INTENT(INOUT) :: a(n,n)
extern "C" void TEST_COMPLEX8(COMPLEX8& c);         //TEST_COMPLEX8(X); COMPLEX(8) X;
extern "C" int SUM(const int& A, const int& B);
extern "C" int SUM1(const int& A, const int& B);


typedef int __stdcall FUNC(const int& n);
extern "C" void EXECUTE_CPP_FUNCTION(const int& n, FUNC** func, int& y);


//COMPLEX(8) X; => struct {float r,i;} x;
class point {
public:
    float x = 1, y = 2, z = 3;
    void print()
    {
        std::cout << " cpp exe  point:\t\t" << x << "\t" << y << "\t" << z << "\n";
    }
};
extern "C" void TEST_TYPE(point*);

void print(const char *s,double* a, int size)
{
    std::cout << s;
    for (int i = 0; i < size; i++)
        std::cout << a[i] << ",";
    std::cout << "\n";
}

int __stdcall int2int(const int& n)
{
    return n* n;
}

int main()
{
    int x, y;
    x = 13;
    TWICE(x, y);
    std::cout << " cpp_exe.TWICE:\t\t" << x << "\t      " << y << "\n";
    //
    const int size = 2;
    double a[size*size];
    for (int i = 0; i < size; i++)
        for (int j = 0; j < size; j++)
            a[size_t(i)* size+j] = double(i)*10+j;
    //int n = size*size;

    print("cpp_exe.array.0:", a, size * size);
    DOUBLE_ARRAY1(a, size * size);

    //check for NULL array
    DOUBLE_ARRAY1(nullptr, 0);

    print("cpp_exe.array.1:", a, size * size);
    //n = size;
    DOUBLE_ARRAY2(a, size);
    print("cpp_exe.array.2:", a, size * size);
    //
    COMPLEX8 c8(1,2);
    c8.print("cpp_exe.COMPLEX8.0");
    TEST_COMPLEX8(c8);
    c8.print("cpp_exe.COMPLEX8.1");

    //TEST_TYPE
    point d;
    d.print();
    TEST_TYPE(&d);

    std::cout << " cpp_exe.SUM(1, 2)=" << SUM(1, 2) << "\n";
    std::cout << " cpp_exe.SUM1(1, 2)=" << SUM1(1, 2) << "\n";

    int y1;
    FUNC* func = int2int;
    EXECUTE_CPP_FUNCTION(4, &func, y1);
    std::cout << "EXECUTE_CPP_FUNCTION(4, int2int, y),y=" << y1 << "\n";
}
