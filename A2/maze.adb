--A2 3190
--Maze traversal by Christopher Katsaras
--Due: March 3rd/2017
--This program will draw a path through a maze assuming that there is a start point 'o' and an end point 'e'
--Known limitations:
--1. Currently, the path drawn may contain "dead ends" as Prof Wirth said it was alright to leave them in.
--2. Maze must be surrounded by walls. Cannot have a path on the edge of the maze
--3. Filename can only be 50 characters long

with Ada.Text_IO; use Ada.Text_IO;
with Ada.integer_text_IO; use Ada.integer_text_IO;
with Ada.strings.unbounded; use ada.strings.unbounded;
with Ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;
with stack; use stack;
procedure Maze is
	
  infp : file_type;
  line : unbounded_string;
  length : integer := 0; 
  width : integer := 0;
  scanChar : character;
  traversed : boolean := false; 
  filename: String(1 .. 50);
  last: Integer;
  --Cell holds data pertaining to a specific location in the maze
  type cell is
 	record
 		symbol : character;
 		isVisited : Boolean;
 		path: integer;
	end record;
   type mazeStructure is array(1..50,1..50) of cell; 
   maze : mazeStructure; --Maze is simply a 2D array of size 50. (This was the upper bound given by Prof. Wirth)

   currentX : integer := 0; --Variables to hold the data of the currently "popped" cell
   currentY : integer := 0;
   currentSymbol : character;
	
begin

   Put_Line("Input filename");
   Get_Line(filename, last);
   open(infp,in_file,filename);--Opens the maze file
   get(infp,width); --Gets the length and width from user. Works with any dimension given
   get(infp,length);

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
                maze(j,i).path := 2;
   				push(currentSymbol,currentX,currentY);
   			end if; 
   		end loop;
   end loop;

   --Implementation of algorithm given by Prof. Wirth
   --Loops until the stack is empty
   while isEmpty = false loop 
   		pop(currentSymbol,currentX,currentY);

        --If we reatch the end. We are done!
   		if(currentSymbol = 'e') then
   			new_line;
   			maze(currentX,currentY).path := 3;
   			exit;
        --Else if we find a location that is not visited or a wall, push N,S,W and E cells onto stack    
   		elsif(currentSymbol /= '*' and maze(currentX,currentY).isVisited = false) then
   			maze(currentX,currentY).isVisited := true;
   			if(maze(currentX,currentY).symbol /= 'o') then
                 maze(currentX,currentY).path := 1;
            end if;
           
   			if(currentX+1 <= width) then
   				push(maze(currentX+1,currentY).symbol,currentX+1,currentY);
   			end if;	

   			if(currentX-1 >= 1) then
   				push(maze(currentX-1,currentY).symbol,currentX-1,currentY);
   			end if;

   			if(currentY-1 >= 1) then
   				push(maze(currentX,currentY-1).symbol,currentX,currentY-1);
   			end if;

   			if(currentY+1 <= length) then
   				push(maze(currentX,currentY+1).symbol,currentX,currentY+1);
   			end if;
   			
   		end if;

   end loop;

   close(infp); --Closes file

   --Loops though maze and prints final traversed path
   for i in 1..length loop
   		for j in 1..width loop
            if(maze(j,i).path = 0) then
                if(maze(j,i).symbol = '*') then
                    put("*");
                elsif(maze(j,i).symbol = '.') then
                    put(".");    
                end if;    
            elsif(maze(j,i).path = 3) then
                put("e");
            elsif(maze(j,i).path = 2) then
                put("o");        
            else
                put("V");     
            end if;
   		end loop;
   		new_line;
   end loop;

end Maze;

