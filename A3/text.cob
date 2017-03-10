*>A3: Text analyizer
*>By: Christopher Katsaras
*>Due: March 24th/17
*>This program analyizes a textfile of the user's choice

identification division.
program-id. A3text.

environment division.
input-output section.
file-control.
select textFile assign to "vader.txt"*>file-name
	organization is line sequential.

data division.
file section.
FD textFile.
01 input-text	pic x(5008).

working-storage section.
01 storage	pic x(500).
01 file-name  pic x(50).
01 num-sentences pic 9(10).
01 num-words pic 9(10).
01 num-chars pic 9(10).
01 num-nums pic 9(10).
01 trim-count pic 9(10).
01 line-length pic 9(10).
01 i pic 9(10).
77 eof-switch pic 9 value 1.
77 word-flag  pic 9 value 0.
77 final-words pic z(10).
77 final-chars pic z(10).
77 final-sentences pic z(10).
77 final-nums pic z(10).
77 average-sentence pic z(10)9.9.
77 average-word pic z(10)9.9.

procedure division.
	
	move zero to num-chars
	move zero to num-words
	move zero to num-sentences
	move zero to num-nums

	display "Please input the file you wish to analyise"
	*>accept file-name
    open input textFile.

    perform until eof-switch = 0

	    read textFile into input-text
	    	at end 
	    		*>display "End of file"
	    		move zero to eof-switch

	    	not at end
	    		move zero to trim-count
	    		move input-text to storage
	    		*> Flips the string and counts how many spaces there are at the beginning
	    		*> This allows me to disregard trailing spaces
	    		inspect function reverse(storage) tallying trim-count for leading spaces

				COMPUTE line-length = LENGTH OF storage - trim-count
				display storage(1:line-length)
				*>display line-length
				move zero to word-flag
				perform varying i from 1 by 1 until i > line-length
					if storage(i:1) is not = " " then 
						add 1 to num-chars
						if storage(i:1) is alphabetic and word-flag is zero
							move 1 to word-flag
							compute num-words = num-words + 1
						else 
							if storage(i:1) is numeric
								add 1 to num-nums
						else 
							if storage(i:1) is = "." or storage(i:1) is = "?" or storage(i:1) is = "!"   
							    add 1 to num-sentences
							    move zero to word-flag	
						else 
							if storage(i:1) is = "," or storage(i:1) is = ";"   
							    move zero to word-flag	
						end-if	    	    	
						end-if
						end-if

					else 
						move zero to word-flag		
					end-if

				end-perform
	    end-read	
	end-perform
	compute average-sentence = num-words / num-sentences
	compute average-word = num-chars / num-words

	move num-words to final-words
	move num-chars to final-chars
	move num-sentences to final-sentences
	move num-nums to final-nums
	display "Number of chars =                   " no advancing
	display final-chars
	display "Number of words =                   " no advancing
	display final-words
	display "Number of sentences =               " no advancing
	display final-sentences
	display "Number of numbers =                 " no advancing
	display final-nums
	display "Average number of words/sentence = " no advancing 
	display average-sentence
	display "Average number of chars/word =     " no advancing 
	display average-word

    close textFile.
stop run.


