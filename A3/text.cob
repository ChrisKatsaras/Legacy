identification division.
program-id. A3text.

environment division.
input-output section.
file-control.
select textFile assign to file-name
organization is line sequential.

data division.
file section.
FD textFile.
01 sample-input	pic x(1000).

working-storage section.
01 ok	pic x(1000).
77 eof-switch pic 9 value 1.
01 file-name  pic x(50).

procedure division.
	
	display "Please input the file you wish to analyise"
	accept file-name
    open input textFile.
    
    *>perform loop until eof-switch = 0.
	    read textFile 
	    	at end 
	    		move zero to eof-switch
	    	not at end 
	    		move sample-input to ok
	    	display ok
	    end-read.	
    *>loop.


    close textFile.
stop run.