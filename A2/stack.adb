with Ada.Text_IO; use Ada.Text_IO;
package body stack is
	--type list is array(1..100) of character;
 	type node is
 	record
 		symbol : character;
 		x : integer;
 		y : integer;
		end record;
		type list is array(1..100) of node;
		stack : list;
		top : natural := 0;

		procedure push(symbol : in character; x : in integer; y : in integer) is
		begin
			top := top + 1;
			stack(top).symbol := symbol;
			stack(top).x := x;
			stack(top).y := y;
		end push;

		procedure pop(symbol : out character; x : out integer; y : out integer) is
		begin
			symbol := stack(top).symbol;
			x := stack(top).x;
			y := stack(top).y;
			top := top - 1;
		end pop;

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

		function isEmpty return Boolean is
		begin
			if(top = 0) then
				return true;
			else
				return false;
			end if;
		end isEmpty;

		procedure emptyStack is
		begin
			top := 0;
		end emptyStack;

end stack;