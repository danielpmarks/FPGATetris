module CheckRow(
	input integer row_num,
	input logic [0:199] board, 
	output logic [0:199] new_board
);

always_comb begin
	new_board = board;
	
	if(board[(10*row_num) +: 10] == 10'b1111111111)
	begin
       new_board = {10'd0, board[0:(10*row_num) - 1],board[(10*(row_num+1)): 199]};
	end
end

endmodule