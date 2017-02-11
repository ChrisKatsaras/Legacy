package stack is
	procedure push(symbol : in character; x : in integer; y : in integer);
	procedure print;
	procedure pop(symbol : out character; x: out integer; y : out integer);
	procedure emptyStack;
	function isEmpty return Boolean;
end stack;