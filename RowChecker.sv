module RowChecker(
	input Clk, Reset,
	input logic [199:0] game_board,
	output logic [199:0] new_game_board,
	output logic done,
	output integer row_count
);

	logic [199:0] row_check_board, next_row_check_board;
	integer row_cursor, next_row_cursor, row_writer, next_row_writer, count, next_count;
	logic [9:0] cur_read_row, cur_write_row;


	
	always_ff @ (posedge Clk or posedge Reset) begin
		if(Reset) begin
			row_cursor <= 0;
			row_writer <= 0;
			row_check_board <= 200'd0;
			count <= 0;
		end else begin
			row_check_board <= next_row_check_board;
			row_writer <= next_row_writer;
			row_cursor <= next_row_cursor;
			count <= next_count;
		end
	end
	

	always_comb begin
		next_row_check_board = row_check_board;
		cur_read_row = 10'd0;
		cur_write_row = 10'd0;
		next_row_writer = row_writer;
		next_row_cursor = row_cursor;
		new_game_board = game_board;
		done = 1'b0;
		next_count = count;
		row_count = 0;
		unique case(row_cursor)
			20: begin
				new_game_board = row_check_board;
				done = 1'b1;
				row_count = count;
			end
			default: begin
				cur_read_row = game_board[(10*row_cursor) +: 10];
				cur_write_row = next_row_check_board[10*row_writer +: 10];
				if(game_board[(10*row_cursor) +: 10] != 10'b1111111111) begin
						next_row_check_board[10*row_writer +: 10] = game_board[(10*row_cursor) +: 10];
						next_row_writer = row_writer + 1;
				end else begin
					next_count = count + 1;
				end
				next_row_cursor = row_cursor + 1;	  
			end
		endcase
	end



endmodule