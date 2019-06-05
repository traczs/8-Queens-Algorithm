
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with stack; use stack;

--non recursive solution
procedure QueensNR is
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
	--iterative procedure that solves it
	procedure solve8Queens(A:in out Board ;B: integer) is
		start:integer:=1;
		col:integer:=1;
		row:integer:=1;
		row2:integer:=1;
		continue: Boolean;
	begin
		--loop through all the columns in the chess board
		while col <=9 loop
			if col = 9 then
				visual8Queens(A);
			end if;
			continue:=false;
			row:=start;
			--loop through all the rows in the chess board
			while row <9 loop
				--checks if it safe to place the queen in the spot and pushes it to the stack
				if isSafe(A,row,col)=true then
					continue:=true;
					push(row);
					A(row,col):=1;
					col:=col+1;
					exit;
				end if;
			row:=row+1;
			end loop;
			--if there was no place to put the queen, backtrack
			if continue=false then
				if stack_is_empty then
					return;
				end if;
				pop(row2);
				start:=row2;
				col:=col-1;
				A(row2,col):=0;
				start:=start + 1;
			else 
				start:=1;
			end if;
			
			
		end loop;
		
	end solve8Queens;
	
	
	
begin
	for I in 1..8 loop
		for J in 1..8 loop
			myArray(I,J) := 0;
		end loop;
	end loop;
	create(outfp,out_file, "queensNR.txt");
	solve8Queens(myArray,1);
	close(outfp);
end QueensNR;
