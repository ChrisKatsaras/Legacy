*>A3: Text analyizer
*>By: Christopher Katsaras
*>Due: March 24th/17
*>This program analyizes a textfile of the user's choice
*>*************************
*>Assumptions/ Limitations:
*>*************************
*>1.A line in a file can only contain a max of 3000 characters
*>2.Number of sentences will not be correct if initials are used e.g J.R.R Tolkien (Approved by Wirth)
*>*********
*>Additions
*>*********
*>1.Given the user the option of what file to write to

identification division.
program-id. A3text.

environment division.
input-output section.
file-control.
select textFile assign to file-name
	organization is line sequential
	file status is file-status.
select outFile	assign to out-name
	organization is line sequential.	

data division.
file section.
fd textFile.
	01 input-text pic x(3000).

fd outFile.
	01 out-text	pic x(3000).

working-storage section.
01 storage	pic x(3000).
01 file-name  pic x(50).
01 out-name  pic x(50).
01 num-sentences pic 9(10).
01 num-words pic 9(10).
01 num-chars pic 9(10).
01 num-nums pic 9(10).
01 trim-count pic 9(10).
01 line-length pic 9(10).
01 i pic 9(10).
77 eof-switch pic 9 value 1.
77 word-flag  pic 9 value 0.
77 number-flag pic 9 value 0.
77 file-status pic xxx.
*>Structures for write to file
01 output-line.
   02  filler        pic x(41) value "-------------------".
01 input-line.
   02  filler        pic x(19) value "Input Text Analyzed".  
01 stats-line.
   02  filler        pic x(25) value "Statistics From Analysis".
01 num-sentences-line.
   02  filler        pic x(35) value "Number of sentences =              ".
   02  final-sentences pic z(10). 
01 num-words-line.
   02  filler        pic x(35) value "Number of words =                  ".
   02  final-words pic z(10).      
01 num-chars-line.
   02  filler        pic x(35) value "Number of chars =                  ".
   02  final-chars pic z(10).
01 average-sentence-line.
   02  filler        pic x(35) value "Average number of words/sentence = ".
   02  average-sentence pic z(10)9.99.
01 average-word-line.
   02  filler        pic x(35)    VALUE "Average number of chars/word =     ".
   02  average-word pic z(10)9.99. 
01 total-numbers-line.
   02  filler        pic x(35)    VALUE "Number of numbers                  ".
   02  final-nums pic z(10).                 

procedure division.
	
	move zero to num-chars
	move zero to num-words
	move zero to num-sentences
	move zero to num-nums

	perform fileOpen

    write out-text from output-line after advancing 0 lines
    write out-text from input-line after advancing 1 lines
   	write out-text from output-line after advancing 1 lines
    
    *>Implementation of state-based parsing
    *>Loops through file reading character by character
    *>Based on the character read, the 'state' changes.
    perform until eof-switch = 0
	    read textFile into input-text
	    	at end 
	    		move zero to eof-switch
	    	not at end
	    		move zero to trim-count
	    		move input-text to storage
	    		*> Flips the string and counts how many spaces there are at the beginning
	    		*> This allows me to disregard trailing spaces
	    		inspect function reverse(storage) tallying trim-count for leading spaces

				compute line-length = length of storage - trim-count

				write out-text from storage after advancing 1 lines
				move zero to word-flag
				perform varying i from 1 by 1 until i > line-length
					if storage(i:1) is not = " " then 
						
						if storage(i:1) is alphabetic
							add 1 to num-chars
							move zero to number-flag	
						end-if
						if storage(i:1) is alphabetic and word-flag is zero
							move 1 to word-flag
							compute num-words = num-words + 1
							move zero to number-flag
						else 
							if storage(i:1) is numeric and number-flag is zero
								add 1 to num-nums
								move 1 to number-flag	
						else 
							if storage(i:1) is = "." or storage(i:1) is = "?" or storage(i:1) is = "!"   
							    add 1 to num-sentences
							    move zero to word-flag
							    move zero to number-flag	
						else 
							if storage(i:1) is = "," or storage(i:1) is = ";"   
							    move zero to word-flag
							    move zero to number-flag	
						end-if	    	    	
						end-if
						end-if

					else 
						move zero to word-flag		
					end-if

				end-perform
	    end-read	
	end-perform
	*>calculates averages 
	compute average-sentence = num-words / num-sentences
	compute average-word = num-chars / num-words
	move num-words to final-words
	move num-chars to final-chars
	move num-sentences to final-sentences
	move num-nums to final-nums
	perform fileWrite	
    close textFile
    close outFile
stop run.

*>Opens files chosen by user
fileOpen.
	display "Please input the file you wish to analyise"
	accept file-name
    open input textFile

    *>Checks to see if file inputted by user exists
    if file-status is equal to '35'
   		close outFile 
    	display "File doesn't exist"
    	stop run
    end-if

    *>Gets user to input output file name
    display "Please input the file you wish to output to"
    accept out-name
    open output outFile.

*>Writes stats to output file
fileWrite.
	write out-text from output-line after advancing 1 lines
    write out-text from stats-line after advancing 1 lines
   	write out-text from output-line after advancing 1 lines
   	write out-text from num-sentences-line after advancing 1 lines	
   	write out-text from num-words-line after advancing 1 lines
   	write out-text from num-chars-line after advancing 1 lines
   	write out-text from total-numbers-line after advancing 1 lines	
   	write out-text from average-sentence-line after advancing 1 lines
   	write out-text from average-word-line after advancing 1 lines.
