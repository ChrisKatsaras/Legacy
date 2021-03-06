       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEXT-STATS.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT INPUT-FILE ASSIGN TO "TEXT.TXT"
              ORGANIZATION IS LINE SEQUENTIAL.
       SELECT OUTPUT-FILE ASSIGN TO "OUT.TXT"
              ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD INPUT-FILE.
       01 SAMPLE-INPUT      PIC X(80).
       FD OUTPUT-FILE. 
       01 OUTPUT-LINE       PIC X(80).

       WORKING-STORAGE SECTION.
       77  EOF-SWITCH       PIC 9        VALUE 1.
       77  EXIT-SWITCH      PIC 9.
       01  NO-OF-SENTENCES  PIC S9(7)    COMP.
       01  NO-OF-WORDS      PIC S9(7)    COMP.
       01  NO-OF-CHARACTERS PIC S9(7)    COMP.
       01  K                PIC S9(2)    COMP.
       01  INPUT-AREA.
           02 LINE1         PIC X        OCCURS 80 TIMES.
       01  OUTPUT-TITLE-LINE.
           02  FILLER        PIC X(31)    VALUE SPACES.
           02  FILLER        PIC X(19)    VALUE "INPUT TEXT ANALYZED".
       01 OUTPUT-UNDERLINE.
           02  FILLER        PIC X(41)    
                    VALUE " ----------------------------------------".
           02  FILLER        PIC X(40)    
                    VALUE "----------------------------------------".
       01 OUTPUT-AREA.
           02  FILLER        PIC X        VALUE SPACE.
           02  OUT-LINE      PIC X(80).
       01 OUTPUT-STATISTICS-LINE-1.
           02  FILLER        PIC X(20)    VALUE SPACES.
           02  FILLER        PIC X(20)    VALUE "NUMBER OF SENTENCES=".
           02  OUT-NO-SENTEN PIC -(7)9.
       01 OUTPUT-STATISTICS-LINE-2.
           02  FILLER        PIC X(19)    VALUE SPACES.
           02  FILLER        PIC X(33)    VALUE "NUMBER OF WORDS=".
           02  OUT-NO-WORD  PIC -(7)9.
       01 OUTPUT-STATISTICS-LINE-3.
           02  FILLER        PIC X(19)    VALUE SPACES.
           02  FILLER        PIC X(33)    VALUE "NUMBER OF CHARS=".
           02  OUT-NO-CHAR  PIC -(7)9.
       01 OUTPUT-STATISTICS-LINE-4.
           02  FILLER        PIC X(19)    VALUE SPACES.
           02  FILLER        PIC X(33)    
                    VALUE "AVERAGE NUMBER OF WORDS/SENTENCE=".
           02  AVER-WORDS-SE PIC -(4)9.9(2).
       01 OUTPUT-STATISTICS-LINE-5.
           02  FILLER        PIC X(20)    VALUE SPACES.
           02  FILLER        PIC X(31)    
                    VALUE "AVERAGE NUMBER OF SYMBOLS/WORD=".
           02  AVER-CHAR-WOR PIC -(4)9.9(2).

       PROCEDURE DIVISION.
       OPEN INPUT INPUT-FILE, OUTPUT OUTPUT-FILE.
       MOVE 2 TO EXIT-SWITCH.
       PERFORM PROC-BODY UNTIL EXIT-SWITCH IS EQUAL TO 3.

       PROC-BODY.
       MOVE ZEROES TO NO-OF-SENTENCES, NO-OF-WORDS, NO-OF-CHARACTERS.
       MOVE 81 TO K.
       WRITE OUTPUT-LINE FROM OUTPUT-TITLE-LINE AFTER ADVANCING 0 LINES.
       WRITE OUTPUT-LINE FROM OUTPUT-UNDERLINE AFTER ADVANCING 1 LINE.
       MOVE 2 TO EXIT-SWITCH.
       PERFORM OUTER-LOOP UNTIL EXIT-SWITCH IS EQUAL TO ZERO.

       OUTER-LOOP.
       READ INPUT-FILE INTO INPUT-AREA AT END PERFORM END-OF-JOB.
       MOVE INPUT-AREA TO OUT-LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-AREA AFTER ADVANCING 1 LINE.
       SUBTRACT 80 FROM K.
       PERFORM NEW-SENTENCE-PROC UNTIL EXIT-SWITCH IS EQUAL TO ZERO 
        OR K IS GREATER THAN 80.

       NEW-SENTENCE-PROC.
       MOVE 2 TO EXIT-SWITCH.
       IF LINE1(K) IS NOT EQUAL TO "/"
           PERFORM PROCESS-LOOP
           UNTIL K IS GREATER THAN 80 OR EXIT-SWITCH IS LESS THAN 2
       ELSE PERFORM OUTPUT-STATISTICS-PROC.

       OUTPUT-STATISTICS-PROC.
       MOVE NO-OF-SENTENCES TO OUT-NO-SENTEN.
       MOVE NO-OF-WORDS TO OUT-NO-WORD.
       MOVE NO-OF-CHARACTERS TO OUT-NO-CHAR.
       DIVIDE NO-OF-SENTENCES INTO NO-OF-WORDS
           GIVING AVER-WORDS-SE ROUNDED.
       DIVIDE NO-OF-WORDS INTO NO-OF-CHARACTERS
           GIVING AVER-CHAR-WOR ROUNDED.
       WRITE OUTPUT-LINE FROM OUTPUT-UNDERLINE AFTER ADVANCING 1 LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-STATISTICS-LINE-1 AFTER ADVANCING 1 LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-STATISTICS-LINE-2 AFTER ADVANCING 1 LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-STATISTICS-LINE-3 AFTER ADVANCING 1 LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-STATISTICS-LINE-4 AFTER ADVANCING 1 LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-STATISTICS-LINE-5 AFTER ADVANCING 1 LINE.
       WRITE OUTPUT-LINE FROM OUTPUT-UNDERLINE AFTER ADVANCING 1 LINE.
       MOVE ZERO TO EXIT-SWITCH.

       PROCESS-LOOP.
       IF LINE1(K) IS EQUAL TO SPACE
           ADD 1 TO NO-OF-WORDS
           ADD 1 TO K
       ELSE IF LINE1(K) IS NOT EQUAL TO "."
               ADD 1 TO K
            IF LINE1(K) IS NOT EQUAL TO "," 
                IF LINE1(K) IS NOT EQUAL TO ";" 
                   IF LINE1(K) IS NOT EQUAL TO "-" 
                      ADD 1 TO NO-OF-CHARACTERS
                   ELSE
                      NEXT SENTENCE
                ELSE
                   NEXT SENTENCE
             ELSE NEXT SENTENCE
       ELSE ADD 1 TO NO-OF-SENTENCES
            ADD 1 TO NO-OF-WORDS
            ADD 3 TO K
            MOVE 1 TO EXIT-SWITCH.

       END-OF-JOB.  
       CLOSE INPUT-FILE, OUTPUT-FILE.

       STOP RUN.
