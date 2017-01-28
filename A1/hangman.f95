program hangman
!A1 CIS*3190
!The Game of Hangman. Converted from Fortran 77 into Fortran 95
!Written by Christopher Katsaras 
!This program plays the game of hangman

integer :: i,j,z,answerLength,validGuess,correctLetter,incorrectGuesses,seed,wordIndex
real :: random
real, dimension(10) :: guessedWords = 0
logical :: freeWords
character :: person(12,12) !2D array that holds the values for the "person" being hanged
character (len = 20) :: answer !Holds the word to be displayed
character (len = 20) :: maskedAnswer !Holds the masked answer to be uncovered by player
character (len = 20) :: userGuess
character, dimension(26) :: guessedLetters !Holds the letters already guessed by the player
character :: guess, playFlag
character (len = 20), dimension(10) :: dictionary
playFlag = 'Y'
data dictionary /'chris','katsaras','john','monkey','tophat','man','backpack','rockstar','bailey','frodo'/
call random_seed(seed) 


!Do while to continually play game
do while(playFlag == 'Y')
    write (*,*) '*******************************'
    write (*,*) 'Welcome to the game of hangman'
    write (*,*) '*******************************'

    person = ' '! Initializes the array to blanks
    call drawNoose(person) !Calls the subroutine to initialize the noose 

    !Initializes the letters guessed to blanks 
    do i=1,26
        guessedLetters(i) = ' '
    end do 
    !Initializes the masked answer to be dashes. As the user guesses correct letters, the masked answer will display the answer
    do i=1,20
        maskedAnswer(i:i) = '-'
    end do
    validGuess = 0
    correctLetter = 0
    incorrectGuesses = 1
    i = 1

    !Loops until a word from the dictionary is picked that the user has not previously played with
    do
        call random_number(random)
        random = random * 100 
        random = MODULO(random,10.0)
        wordIndex = ceiling(random)
        if(guessedWords(wordIndex) == 0) then
            guessedWords(wordIndex) = 1
            answer = dictionary(wordIndex)
            answerLength = LEN_TRIM(answer)!Calculates length of answers
            exit
        end if   
    end do 

    !Game is played until the user makes 10 incorrect guesses
    do while(incorrectGuesses <= 10)
        
        write (*,*) maskedAnswer(1:answerLength)
        write (*,*) 'Here are the letters you have guessed already' 
        write (*,*) guessedLetters(1:10)

        do while(validGuess == 0)

            write (*,*) 'Please input a letter to guess'
            read (*,*) guess

            do j=1,26
                !If the letter has already been guessed then we must reask the user
                if(guess == guessedLetters(j)) then
                    write (*,*) 'You guessed this letter already!'
                    write (*,*) 'Please try again'
                    validGuess = 0
                    exit
                else
                    validGuess = 1    
                end if    
            end do 
        end do
        guessedLetters(i) = guess

        !Fills in the masked answer with correct letters guessed by user
        do j=1,answerLength
            if(guessedLetters(i) == answer(j:j)) then
                maskedAnswer(j:j) = guessedLetters(i)
                correctLetter = 1
            end if 
        end do

        !Draws the updated noose if the user guessed incorrectly
        if(correctLetter == 0) then

            select case (incorrectGuesses)
                case (1)
                    write(*,*)'First we draw a head.'
                    person(3,6) = '-'; person(3,7) = '-'; person(3,8) = '-'; person(4,5) = '('; person(4,6) = '.'; 
                    person(4,8) = '.'; person(4,9) = ')'; person(5,6) = '-'; person(5,7) = '-'; 
                    person(5,8) = '-';
                case (2)
                    write(*,*)'Now we draw a body.'
                    do j=6,9
                        person(j,7) = 'X'
                    end do
                case (3)
                    write(*,*) 'Next we draw an arm.'
                    do j=4,7
                        person(j,j-1) = '\'
                    end do     
                case (4)
                    write(*,*) 'This time it`s the other arm.'
                    do j=4,7
                        person(4,11) = "/"; person(5,10) = "/"; person(6,9) = "/"; person(7,8) = "/"; 
                    end do
                case (5)
                     write(*,*) 'Now, let`s draw the right leg.'
                     person(10,6) = '/'; person(11,5) = '/';
                case (6)
                     write(*,*) 'This time we draw the left leg.'
                     person(10,8) = '\'; person(11,9) = '\';
                case (7)
                     write(*,*) 'Now we put up a hand.'
                     person(3,11) = '\';
                case (8)
                     write(*,*) 'Next the other hand.'
                     person(3,3) = '/';
                case (9)
                     write(*,*) 'Now we draw one foot.'
                     person(12,10) = '\'; person(12,11) = '-';
                case (10)
                     write(*,*) 'Here`s the other foot -- You`re hung!!.'
                     person(12,3) = '-'; person(12,4) = '/' 
            end select

            !Prints the updated noose
            do z=1,12
                WRITE (*,*) (person(z,j),j=1,12)
            end do
            incorrectGuesses = incorrectGuesses + 1
        else
            write (*,*) maskedAnswer(1:answerLength)
            write(*,*) 'What is your guess for the word?'
            read(*,*) userGuess
            if(userGuess == answer) then
                write(*,*) 'That is correct!'
                exit
            else
                write(*,*) 'This is incorrect! Try another letter!'  
            end if    

        end if    

        validGuess = 0 !Resets unique guess token
        correctLetter = 0 !Resets correct guess token

        if(answer(1:answerLength) == maskedAnswer(1:answerLength)) then
            write(*,*) 'You guessed the word'
            exit
        end if

        i = i + 1
    end do
    !Checks to see if there are words left to play with
    call availableWords(guessedWords,freeWords)
    if(freeWords .eqv. .false.) then
        write (*,*) "There are no words left"
        playFlag = 'N'
    else
        write(*,*) 'Would you like to play again? (Y/N)'
        read(*,*) playFlag !Prompts the user if they would like to play again
    end if   
    

end do

write(*,*) 'Thanks for playing'

end

!Subroutine that draws the structure of the noose in x's 
subroutine drawNoose(person)

character :: person(12,12)

do i = 1, 12
    person(i,1) = 'X'
end do

do i = 1, 7
    person(1,i) = 'X'
end do

return
end subroutine drawNoose

!Subroutine that checks to see if there are still words available for the user to play with
subroutine availableWords(guessedWords, freeWords)

real :: guessedWords(5)
logical :: freeWords

!Loops through the guessedWors array and returns true if there is an available word for the user to play with
do i = 1, size(guessedWords)
    if(guessedWords(i) == 0) then
        freeWords = .true.
        exit
    else
        freeWords = .false.     
    end if  
end do

return
end subroutine availableWords    