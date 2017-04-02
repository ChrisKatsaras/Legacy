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
last : Integer;
	
begin

   Put_Line("Please input an algebraic expression to convert");
   Get_Line(originalString, last);

end polish;

