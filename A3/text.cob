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
01 input-text	pic x(500).

working-storage section.
01 storage	pic x(500).
01 file-name  pic x(50).
01 num-sentences pic 9(10).
01 num-words pic 9(10).
01 num-chars pic 9(10).
01 trim-count pic 9(10).
01 line-length pic 9(10).
01 i pic 9(10).
77 eof-switch pic 9 value 1.
77 word-flag  pic 8 value 0.

procedure division.
	
	move zero to num-chars
	move zero to num-words
	move zero to num-sentences

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
	    		INSPECT function reverse(storage) tallying trim-count for leading spaces

				COMPUTE line-length = LENGTH OF storage - trim-count
				display storage(1:line-length)
				*>display line-length

				perform varying i from 1 by 1 until i > line-length
					if storage(i:1) is not = " " then 
						add 1 to num-chars
						if storage(i:1) is alphabetic

					else 
						move zero to word-flag		
					end-if 

				end-perform
	    end-read	
	end-perform
	display num-chars

    close textFile.
stop run.


