!A4: Reverse polish form
!Written by Christopher Katsaras
!April 7th
!
!***********
!Compile/run
!***********
!Type "gfortran polish.f95" to compile 
!Type "./a.out" to run
!
!*****************
!Known limitations
!*****************

program polish

character (len = 40) :: originalString, polishString
integer :: answerLength, i 

write(*,*) "Please input an algebraic expression to convert"
read(*,*) originalString
answerLength = len_trim(originalString)

do i=1,answerLength

    if(originalString(i:i) >= 'a' .AND. originalString(i:i) <= 'z') then
        write(*,*) "letter"
    end if
    if(originalString(i:i) >= '0' .AND. originalString(i:i) <= '9') then
        write(*,*) "num"
    end if

end do

end


