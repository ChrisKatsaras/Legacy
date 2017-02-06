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
  

   type cell is
 	record
 		symbol : character;
 		isVisited : Boolean;
	end record;
   type mazeStructure is array(1..50,1..50) of cell;
   maze : mazeStructure;

   currentX : integer := 0;
   currentY : integer := 0;
   currentSymbol : character := 'o';
	
begin

   --Put_Line("Input filename");
   --get_line(filename);
   open(infp,in_file,"maze.txt");--Gotta fix this to work with filename
   get(infp,length);
   get(infp,width);

   --Scans maze from file into 2D array that holds maze values
   for i in 1..length loop
   		for j in 1..width loop
   			get(infp,scanChar);
   			maze(i,j).symbol := scanChar;
   			if(scanChar = 'o') then
   				currentX := i;
   				currentY := j;
   				currentSymbol := 'o';
   				push(currentSymbol,currentX,currentY);
   				maze(i,j).isVisited := true;
   			end if; 
   		end loop;
   end loop;

   while isEmpty = false loop 
   		put("Looking a cell at location");
   		pop(currentSymbol,currentX,currentY);
   		put(Integer'image(currentX));
   		put(Integer'image(currentY));
   		if(currentSymbol = 'e') then
   			put("We found the end!");
   		elsif(maze(currentX,currentY).symbol /= '*' and maze(currentX,currentY).isVisited = false) then
   			maze(currentX,currentY).isVisited := true;
   			if(currentY+1 <= width) then
   				push(maze(currentX,currentY).symbol,currentX,currentY+1);
   			end if;
   		end if;
   end loop;

   --push('x',2,3);
   --push('*',10,2);	
   --print;
   close(infp);

end Maze;

