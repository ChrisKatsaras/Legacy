identification division.
program-id. A3text.

environment division.
input-output section.
file-control.
select textFile assign to "text.txt"
organization is line sequential.

data division.
file section.
FD textFile.
01 sample-input	pic x(1000).

working-storage section.
01 ok	pic x(1000).
77 eof-switch pic 9 value 1.

procedure division.

    open input textFile.
    read textFile 
    	at end move zero to eof-switch
    	not at end move sample-input to ok
    end-read.	
    display ok

    close textFile.
