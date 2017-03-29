!A4: Reverse polish form
!Written by Christopher Katsaras
!April 7th
!
!***********
!Compile/run
!***********
!Type "make fortran" or "gfortran polish.f95" to compile 
!Type "./a.out" to run
!
!*****************
!Known limitations
!*****************

program polish

character (len = 40) :: originalString, polishString, stack
integer :: answerLength, i, polishLength, top, test, priority

polishLength = 1
top = 0
stack(top:top) = '%'
 
write(*,*) "Please input an algebraic expression to convert"
read(*,*) originalString
answerLength = len_trim(originalString)

do i=1,answerLength
    select case (originalString(i:i))
        case ('%','+','-','*','/','^')!,'(',')')
            do
                if (priority(originalString(i:i)) > priority(stack(top:top))) then
                    top = top + 1
                    stack(top:top) = originalString(i:i)
                    exit
                else 
                    polishLength = polishLength + 1
                    polishString(polishLength:polishLength) = stack(top:top)
                    top = top - 1               
                endif
            end do
        case ('(',')')
            if(originalString(i:i) == '(') then
                top = top + 1
                stack(top:top) = '('
            else if(originalString(i:i) == ')') then
                do while(priority(stack(top:top)) /= priority('('))
                    polishLength = polishLength + 1
                    polishString(polishLength:polishLength) = stack(top:top)
                    top = top - 1
                end do
                top = top - 1
            end if
        case ('a':'z','A':'Z','0':'9')
            polishLength = polishLength + 1
            polishString(polishLength:polishLength) = originalString(i:i)    
    end select

end do

do
    polishLength = polishLength + 1
    polishString(polishLength:polishLength) = stack(top:top)
    top = top - 1 
    if(top <= 0) then
        exit
    end if
end do

write(*,*) polishString(1:polishLength);


end

integer function priority(sym)
    character :: sym
    select case(sym)
        case(')','%')
            priority = -1
        case('(')
            priority = 0
        case('+','-')   
            priority = 1
        case('*','/')
            priority = 2
        case('^')
            priority = 3        
    end select
end function priority

