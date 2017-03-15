*>A3: Text analyizer
*>By: Christopher Katsaras
*>Due: March 24th/17
*>This program analyizes a textfile of the user's choice
*>Assumptions/ Limitations:
*>1.A line in a file can only contain a max of 3000 characters
*>2.

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
	01 input-text	pic x(3000).

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
77 file-status pic XXX.
*>Structures for write to file
01 output-line.
   02  FILLER        PIC X(41) VALUE "-------------------".
01 input-line.
   02  FILLER        PIC X(19) VALUE "Input Text Analyzed".  
01 stats-line.
   02  FILLER        PIC X(25) VALUE "Statistics From Analysis".
01 num-sentences-line.
   02  FILLER        PIC X(35)    VALUE "Number of sentences =              ".
   02  final-sentences pic z(10). 
01 num-words-line.
   02  FILLER        PIC X(35)    VALUE "Number of words =                  ".
   02  final-words pic z(10).      
01 num-chars-line.
   02  FILLER        PIC X(35)    VALUE "Number of chars =                  ".
   02  final-chars pic z(10).
01 average-sentence-line.
   02  FILLER        PIC X(35)    VALUE "Average number of words/sentence = ".
   02  average-sentence pic z(10)9.9.
01 average-word-line.
   02  FILLER        PIC X(35)    VALUE "Average number of chars/word =     ".
   02  average-word pic z(10)9.9. 
01 total-numbers-line.
   02  FILLER        PIC X(35)    VALUE "Number of numbers                  ".
   02  final-nums pic z(10).                 

procedure division.
	
	move zero to num-chars
	move zero to num-words
	move zero to num-sentences
	move zero to num-nums

	display "Please input the file you wish to analyise"
	accept file-name
    open input textFile.

    if file-status is equal to '35'
   		close outFile 
    	display "File doesn't exist"
    	stop run
    end-if
    display "Please input the file you wish to output to"
    accept out-name
    open output outFile.
    write out-text from output-line after advancing 0 lines
    write out-text from input-line after advancing 1 lines
   	write out-text from output-line after advancing 1 lines
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
	*>calculates averages 
	compute average-sentence = num-words / num-sentences
	compute average-word = num-chars / num-words
	move num-words to final-words
	move num-chars to final-chars
	move num-sentences to final-sentences
	move num-nums to final-nums

	*>Writes stats to output file
	write out-text from output-line after advancing 1 lines
    write out-text from stats-line after advancing 1 lines
   	write out-text from output-line after advancing 1 lines
   	write out-text from num-sentences-line after advancing 1 lines	
   	write out-text from num-words-line after advancing 1 lines
   	write out-text from num-chars-line after advancing 1 lines
   	write out-text from total-numbers-line after advancing 1 lines	
   	write out-text from average-sentence-line after advancing 1 lines
   	write out-text from average-word-line after advancing 1 lines	
   		
    close textFile
    close outFile
stop run.


