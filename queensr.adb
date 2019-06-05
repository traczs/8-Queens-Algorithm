
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

--recursive solution
procedure QueensR is
	type Board is array (1..8,1..8) of integer;
	myArray: Board;
	outfp : file_type;
	count:integer:=1; 
	--checks if a queen can be placed on the board spot
	function isSafe(A: in out Board;B:integer;C:integer) return Boolean is
		row :integer:= 0;
		column:integer:=0;
	begin
		row:=B;
		column:=C;
		for I in Integer range 1..column loop
			if A(row,I)=1 then
				return false;
			end if;
		end loop;
		row:=B;
		column:=C;
		while row/=0 and column/=0 loop
			if A(row,column)=1 then
				return false;
			end if;
			row:=row -1;
			column:=column-1;
		end loop;
		row:=B;
		column:=C;
		while row<9 and column/=0 loop
			if A(row,column)=1 then
				return false;
			end if;
			row:=row +1;
			column:=column-1;
		end loop;
		return true;
	end isSafe;
	
	--this will print all solutions to the file
	procedure visual8Queens(A: Board) is
		
	begin
		put(outfp,count);
		count:= count+1;
		put_line(outfp,"");
		for I in 1..8 loop
			for J in 1..8 loop
				if A(I,J)=1 then
					put(outfp,"Q");
				elsif A(I,J)=0 then
					put(outfp,".");
				end if;
			end loop;
			put_line(outfp,"");
		end loop;
		put_line(outfp,"");
		
	end visual8Queens;
	
	procedure solve8Queens(A:in out Board ;B: integer) is
		
	begin
		
		if B=9 then
			visual8Queens(A);
		end if;
			
		for I in 1..8 loop
			if isSafe(A,I,B)=true then
				A(I,B):= 1;
				solve8Queens(A,B+1);
				A(I,B):= 0;
			end if;
		end loop;
	end solve8Queens;
	
	
	
begin
	for I in 1..8 loop
		for J in 1..8 loop
			myArray(I,J) := 0;
		end loop;
	end loop;
	create(outfp,out_file, "queensR.txt");
	solve8Queens(myArray,1);
	close(outfp);
end QueensR;
