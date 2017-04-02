--A4: Reverse polish form
--Written by Christopher Katsaras
--April 7th
--
--***********
--Compile/run
--***********
--Type "make ada"
--Type "./a.out" to run
--
--*****************
--Known limitations
--*****************
--
--

with Ada.Text_IO; use Ada.Text_IO;
with Ada.integer_text_IO; use Ada.integer_text_IO;
with Ada.strings.unbounded; use ada.strings.unbounded;
with Ada.strings.unbounded.Text_IO; use ada.strings.unbounded.Text_IO;

procedure polish is

originalString: String(1 .. 40);
polishString: String(1 .. 40);
stack : String(1 .. 40);
polishLength : Integer;
length : Integer;
top : Integer;
currentChar : character;

function priority(sym:character) return Integer is
begin
	case sym is
		when ')' | '%' =>
			return -1;
		when '(' =>
			return 0;
		when '+' | '-' =>
			return 1;
		when '*' | '/' =>
			return 2;
		when '^' =>
			return 3;			
		when others =>
			put_line("Invalid symbol");
			return -2;
	end case;
end priority;

procedure push(sym:character) is
begin
	top := top + 1;
	stack(top) := sym;
end push;

procedure pop(sym:character) is
begin
   polishLength := polishLength + 1;
   polishString(polishLength) := sym;
   top := top - 1;
end pop;
	
begin
   polishLength := 0;
   top := 1;
   stack(top) := '%';

   Put_Line("Please input an algebraic expression to convert");
   Get_Line(originalString, length);

   for i in 1..length loop
   		currentChar := originalString(i);
   		case currentChar is
   			when 'a'..'z' | 'A'..'Z' | '0'..'9' => 
   				polishLength := polishLength + 1;
   				polishString(polishLength) := currentChar;
   			when '%' | '+' | '-' | '*' | '/' | '^' => 
      				loop
                  if(priority(currentChar) > priority(stack(top))) then
      					push(currentChar);
                     exit;
                  else
                     pop(currentChar);    
      				end if;

               end loop;

   			when '(' | ')' => 
   				if(currentChar = '(') then
                  push(currentChar);
               else
                  while (priority(stack(top)) /= priority('(')) loop
                     pop(currentChar);
                  end loop;   
                  top := top -1;
               end if;
   			when others => 
   				put_line("Invalid operator!");
   		end case;	
   end loop;

   while top > 1 loop
      if(stack(top) = '(') then
         put_line("Unmatched bracket");
      else
         polishLength := polishLength + 1;
         polishString(polishLength) := stack(top);
      end if;
      top := top - 1;
   end loop;

   for i in 1..polishLength loop
   		put(polishString(i));

   end loop;
   new_line;
   put_line("Goodbye");


end polish;

