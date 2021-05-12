module tetris_row_map(
	input logic [9:0] row, x,
	input logic [9:0] piece_row,
	output logic BlockOn, PieceOn
	
);
	
	always_comb
	begin



		if(x < 10'd20)begin
			BlockOn = row[9];
			PieceOn = piece_row[9];
		end
		else if(x < 10'd40)
		begin
			BlockOn = row[8];
			PieceOn = piece_row[8];
		end
		else if(x < 10'd60)
		begin
			BlockOn = row[7];
			PieceOn = piece_row[7];
		end
		else if(x < 10'd80)
		begin
			BlockOn = row[6];
			PieceOn = piece_row[6];
		end
		else if(x < 10'd100)
		begin
			BlockOn = row[5];
			PieceOn = piece_row[5];
		end
		else if(x < 10'd120)
		begin
			BlockOn = row[4];
			PieceOn = piece_row[4];
		end
		else if(x < 10'd140)
		begin
			BlockOn = row[3];
			PieceOn = piece_row[3];
		end
		else if(x < 10'd160)
		begin
			BlockOn = row[2];
			PieceOn = piece_row[2];
		end
		else if(x < 10'd180)
		begin
			BlockOn = row[1];
			PieceOn = piece_row[1];
		end
		else
		begin
			BlockOn = row[0];
			PieceOn = piece_row[0];
		end
	
	end

endmodule