with Ada.Text_IO; use Ada.Text_IO;
procedure Maze is

   infp : file_type;
   filename : string(1..80);
begin

   Put_Line("Input filename");
   get(filename);
   open(infp,in_file,"maze.txt");



   close(infp);
end Maze;