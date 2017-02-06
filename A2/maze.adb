with Ada.Text_IO; use Ada.Text_IO;
with Ada.integer_text_IO; use Ada.integer_text_IO;
with Ada.strings.unbounded; use ada.strings.unbounded;
with Ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with stack; use stack;
procedure Maze is
	
  	

   infp : file_type;
   filename : unbounded_string;
   line : unbounded_string;
   length : integer := 0; 
   width : integer := 0;
   scanChar : character;
   maze : array(1..50,1..50) of character;
   currentX : integer;
   currentY : integer;
   currentSymbol : character;
	
begin

   Put_Line("Input filename");
   --get_line(filename);
   open(infp,in_file,"maze.txt");--Gotta fix this to work with filename
   get(infp,length);
   get(infp,width);

   --Scans maze from file into 2D array that holds maze values
   for i in 1..length loop
   		for j in 1..width loop
   			get(infp,scanChar);
   			maze(i,j) := scanChar;
   			if(scanChar = 'e') then
   				currentX := i;
   				currentY := j;
   				currentSymbol := 'e';
   			end if; 
   		end loop;
   end loop;

   push('x',2,3);
   push('*',10,2);	
   pop(currentSymbol,currentX,currentY);
   print;
   close(infp);

end Maze;

