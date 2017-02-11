--Created a package to deal with stack related functions
--This can help to make the program modular.
with Ada.Text_IO; use Ada.Text_IO;
package body stack is
 	--Node holds data pertaining to a specific cell in the maze  
 	type node is
 		record
 			symbol : character; 
 			x : integer;
 			y : integer;
		end record;
		type list is array(1..100) of node;--The stack is simply an array of type node.
		stack : list;
		top : natural := 0;

		--Pushes maze location onto the stack
		procedure push(symbol : in character; x : in integer; y : in integer) is
		begin
			top := top + 1;
			stack(top).symbol := symbol;
			stack(top).x := x;
			stack(top).y := y;
		end push;

		--Pops maze location off of the stack
		procedure pop(symbol : out character; x : out integer; y : out integer) is
		begin
			symbol := stack(top).symbol;
			x := stack(top).x;
			y := stack(top).y;
			top := top - 1;
		end pop;

		--Prints contents of stack
		procedure print is
		begin
			for i in 1..top loop
				put("(");
				put(stack(i).symbol);
				put(Integer'image(stack(i).x));
				put(Integer'image(stack(i).y));
				put(")");
			end loop; 
		end print;

		--Checks to see if the stack is empty
		function isEmpty return Boolean is
		begin
			if(top = 0) then
				return true;
			else
				return false;
			end if;
		end isEmpty;

		--Empties the stack 
		procedure emptyStack is
		begin
			top := 0;
		end emptyStack;

end stack;