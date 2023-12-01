MODULE cpp_if
    interface
        function cpp_function(n) result(y)
            integer, intent(in) :: n
            integer :: y
        end function cpp_function
    end interface
    contains
    end module cpp_if
    
subroutine TWICE(x,y)
    IMPLICIT NONE
    !DEC$ ATTRIBUTES DLLEXPORT::TWICE
    INTEGER, INTENT(IN) :: x
    INTEGER, INTENT(OUT) :: y
    y=2*x
    print *, 'fortran_dll.TWICE:',x,' ', y
END SUBROUTINE TWICE

subroutine DOUBLE_ARRAY1(a,n)
    IMPLICIT NONE
    !DEC$ ATTRIBUTES DLLEXPORT::DOUBLE_ARRAY1
    INTEGER , INTENT(IN) :: n
    REAL*8 , INTENT(INOUT) :: a(n)
        
    INTEGER :: I;
    
    !REAL*8,target,save :: r
    !REAL*8, pointer :: pa => a(1)
    !if(pa .eq. NULL()) then
    !endif
    
    print *, 'fortran_dll.array1:',n,a
	DO I=1,n
        a(I)=a(I)*10
    ENDDO
END SUBROUTINE DOUBLE_ARRAY1

subroutine DOUBLE_ARRAY2(a,n)
    IMPLICIT NONE
    !DEC$ ATTRIBUTES DLLEXPORT::DOUBLE_ARRAY2
    INTEGER , INTENT(IN) :: n
    REAL*8 , INTENT(INOUT) :: a(n,n)
    INTEGER :: I;
    INTEGER :: J;
    print *, 'fortran_dll.array2:',n,a
	DO I=1,n
	DO J=1,n
        a(I,J)=a(I,J)*10
    ENDDO
    ENDDO
END SUBROUTINE DOUBLE_ARRAY2
    
subroutine TEST_COMPLEX8(c8)
    IMPLICIT NONE
    !DEC$ ATTRIBUTES DLLEXPORT::TEST_COMPLEX8
    COMPLEX*8 , INTENT(INOUT) :: c8
    print *, 'fortran_dll.TEST_COMPLEX8:',c8
    c8=CMPLX(17,13)
END SUBROUTINE TEST_COMPLEX8

SUBROUTINE TEST_TYPE( P )
    IMPLICIT NONE
     !DEC$ ATTRIBUTES DLLEXPORT::TEST_TYPE
    TYPE POINT
        REAL :: X, Y, Z
    END TYPE POINT
    TYPE (POINT) P

    print *, 'fortran_dll.point:',P%X,P%Y,P%Z
    END SUBROUTINE TEST_TYPE
    
integer function SUM(A,B)    
    !DEC$ ATTRIBUTES DLLEXPORT::SUM
    IMPLICIT NONE
    INTEGER , INTENT(IN) :: A,B
    SUM=A+B
    print *, 'fortran_dll.SUM:',A,B,SUM
    end function SUM

function SUM1(a,b) result(y)
    !DEC$ ATTRIBUTES DLLEXPORT::SUM1
    IMPLICIT NONE
    INTEGER , INTENT(IN) :: A,B
    INTEGER :: y
    y=A+B
    print *, 'fortran_dll.SUM1:',A,B,y
    END FUNCTION SUM1
    
SUBROUTINE EXECUTE_CPP_FUNCTION(n,func,y)
    !DEC$ ATTRIBUTES DLLEXPORT::EXECUTE_CPP_FUNCTION
    use cpp_if
    INTEGER, INTENT(in) :: n
    PROCEDURE(cpp_function), POINTER :: func
    INTEGER, INTENT(out) :: y
    y = func(n)
    print *, 'fortran_dll.execute_cpp_function:',n,y
    END SUBROUTINE execute_cpp_function

