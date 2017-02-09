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
   turns : integer := 0;
   scanChar : character;

   type cell is
 	record
 		symbol : character;
 		isVisited : Boolean;
 		path: integer;
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
   			maze(j,i).symbol := scanChar;
   			maze(j,i).path := 0;
            maze(j,i).isVisited := false;
   			if(scanChar = 'o') then
   				currentX := j;
   				currentY := i;
   				currentSymbol := 'o';
   				push(currentSymbol,currentX,currentY);
   				--maze(i,j).isVisited := true;
   			end if; 
   		end loop;
   end loop;

   while isEmpty = false loop 
   		put("Looking a cell at location"); new_line;
   		pop(currentSymbol,currentX,currentY);
   		put(Integer'image(currentX));
   		put(Integer'image(currentY));
   		put(currentSymbol);

   		if(currentSymbol = 'e') then
   			put("We found the end!");
   			new_line;
   			maze(currentX,currentY).path := 1;
   			put("Printing stack");
   			print;
   			exit;
   		elsif(currentSymbol /= '*' and maze(currentX,currentY).isVisited = false) then
   			maze(currentX,currentY).isVisited := true;
   			maze(currentX,currentY).path := 1;

			put("Pushing East Cell"); new_line;
			push(maze(currentX+1,currentY).symbol,currentX+1,currentY);



			put("Pushing West Cell"); new_line;
			push(maze(currentX-1,currentY).symbol,currentX-1,currentY);



			put("Pushing North Cell"); new_line;
			push(maze(currentX,currentY-1).symbol,currentX,currentY-1);

			put("Pushing south Cell"); new_line;
			push(maze(currentX,currentY+1).symbol,currentX,currentY+1);

        elsif (maze(currentX,currentY).isVisited = true) then

        put("BEEN VISITED");
   			
   		end if;

   		new_line;
   end loop;


   close(infp);

   for i in 1..length loop
   		for j in 1..width loop
   			put(Integer'image(maze(j,i).path));
   		end loop;
   		new_line;
   end loop;
   put(Integer'image(turns));

end Maze;

