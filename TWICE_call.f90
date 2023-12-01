module mydll
    interface
        integer function SUM(A,B)
            implicit none
            integer, intent (in) :: A,B
        end function SUM
        integer function SUM1(A,B)
            implicit none
            integer, intent (in) :: A,B
        end function     
        
        function cpp_function(n) result(y)
            integer, intent(in) :: n
            integer :: y
        end function cpp_function
        
        subroutine EXECUTE_CPP_FUNCTION(n,func,y)
            integer, intent(in) :: n
            interface
                    function ftemplate(n) result(y)
                        integer, intent(in) :: n
                        integer :: y
                    end function ftemplate
            end interface
            PROCEDURE(ftemplate), POINTER :: func
            integer, intent(out) :: y
        end subroutine EXECUTE_CPP_FUNCTION        

    end interface
    CONTAINS
end module mydll
    
program TWICE_call
    use mydll
    implicit none
    !DEC$ ATTRIBUTES DLLIMPORT ::TWICE
    !!DEC$ ATTRIBUTES DLLIMPORT ::SUM
    !!DEC$ ATTRIBUTES DLLIMPORT ::SUM1
    INTEGER :: x,y
    INTEGER s
    PROCEDURE(cpp_function), POINTER :: func
    
    x=13
    CALL TWICE(x,y)
    print *, 'fortran_exe.TWICE:',x,' ', y
    print *, 'fortran_exe.SUM(1,2)',SUM(1,2)
    print *, 'fortran_exe.SUM1(1,2)',SUM1(1,2)
    
    func => fortran_func
    
    call EXECUTE_CPP_FUNCTION(4,func,y)
    PRINT*, 'fortran_exe.EXECUTE_CPP_FUNCTION(4,func,y)',y
CONTAINS
    FUNCTION fortran_func(n) RESULT(y)
        INTEGER, INTENT(in) :: n
        INTEGER :: y
        y = n*n
    END FUNCTION fortran_func    
end program TWICE_call

