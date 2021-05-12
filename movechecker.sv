module MoveChecker (
	input [0:15] piece,
	input [0:199] iboard,
    input integer x,
    input integer y,
	 output logic L,
    output logic D,
    output logic R,
	 output logic C
);

    logic [0:15] arrD;
    logic [0:15] arrL;
	logic [0:15] arrR; 
	logic [0:15] arrC;
		
    // Checks each of the 16 bits in the piece 
    bitMoveChecker bit0(piece[0], x, y, iboard, arrD[0], arrL[0], arrR[0], arrC[0]);
    bitMoveChecker bit1(piece[1], x + 1, y, iboard, arrD[1], arrL[1], arrR[1], arrC[1]);
    bitMoveChecker bit2(piece[2], x + 2, y, iboard, arrD[2], arrL[2], arrR[2], arrC[2]);
    bitMoveChecker bit3(piece[3], x + 3, y, iboard, arrD[3], arrL[3], arrR[3], arrC[3]);
    bitMoveChecker bit4(piece[4], x, y + 1, iboard, arrD[4], arrL[4], arrR[4], arrC[4]);
    bitMoveChecker bit5(piece[5], x + 1, y + 1, iboard, arrD[5], arrL[5], arrR[5], arrC[5]);
    bitMoveChecker bit6(piece[6], x + 2, y + 1, iboard, arrD[6], arrL[6], arrR[6], arrC[6]);
    bitMoveChecker bit7(piece[7], x + 3, y + 1, iboard, arrD[7], arrL[7], arrR[7], arrC[7]);
    bitMoveChecker bit8(piece[8], x, y + 2, iboard, arrD[8], arrL[8], arrR[8], arrC[8]);
    bitMoveChecker bit9(piece[9], x + 1, y + 2, iboard, arrD[9], arrL[9], arrR[9], arrC[9]);
    bitMoveChecker bit10(piece[10], x + 2, y + 2, iboard, arrD[10], arrL[10], arrR[10], arrC[10]);
    bitMoveChecker bit11(piece[11], x + 3, y + 2, iboard, arrD[11], arrL[11], arrR[11], arrC[11]);
    bitMoveChecker bit12(piece[12], x, y + 3, iboard, arrD[12], arrL[12], arrR[12], arrC[12]);
    bitMoveChecker bit13(piece[13], x + 1, y + 3, iboard, arrD[13], arrL[13], arrR[13], arrC[13]);
    bitMoveChecker bit14(piece[14], x + 2, y + 3, iboard, arrD[14], arrL[14], arrR[14], arrC[14]);
    bitMoveChecker bit15(piece[15], x + 3, y + 3, iboard, arrD[15], arrL[15], arrR[15], arrC[15]);

    assign D = arrD[0] & arrD[1] & arrD[2] & arrD[3] & arrD[4] & arrD[5] & arrD[6] & arrD[7] & arrD[8] & arrD[9] & arrD[10] & arrD[11] & arrD[12] & arrD[13] & arrD[14] & arrD[15];
    assign L = arrL[0] & arrL[1] & arrL[2] & arrL[3] & arrL[4] & arrL[5] & arrL[6] & arrL[7] & arrL[8] & arrL[9] & arrL[10] & arrL[11] & arrL[12] & arrL[13] & arrL[14] & arrL[15];
    assign R = arrR[0] & arrR[1] & arrR[2] & arrR[3] & arrR[4] & arrR[5] & arrR[6] & arrR[7] & arrR[8] & arrR[9] & arrR[10] & arrR[11] & arrR[12] & arrR[13] & arrR[14] & arrR[15];
	 assign C = arrC[0] & arrC[1] & arrC[2] & arrC[3] & arrC[4] & arrC[5] & arrC[6] & arrC[7] & arrC[8] & arrC[9] & arrC[10] & arrC[11] & arrC[12] & arrC[13] & arrC[14] & arrC[15];

endmodule

module bitMoveChecker (
	 input piece,
    input integer x,
    input integer y,
    input [0:199] iboard,
    output logic D,
    output logic L,
    output logic R,
	 output logic C
);

	// Temp vars
	logic Lt;
	logic Dt;
	logic Rt;
	logic Ct;
	cLeft check1(x, y, iboard, Lt);
	cDown check2(x, y, iboard, Dt);
	cRight check3(x, y, iboard, Rt);
	cCurr check4(x, y, iboard, Ct);
	
	always_comb begin
		if(piece == 1) begin
			R = Rt;
			D = Dt;
			L = Lt;
			C = Ct;
		end
		else begin
			R = 1;
			D = 1;
			L = 1;
			C = 1;
		end
	end
endmodule

module cLeft (
    input integer x,
    input integer y,
    input [0:199] iboard,
    output logic canMove
);
	always_comb begin
		canMove = 1;
		if(x == 0) begin
				canMove = 0;
		end
		if(iboard[(y * 10) + x - 1] == 1) begin // Checks left
			canMove = 0;
		end
	end
endmodule

module cRight (
    input integer x,
    input integer y,
    input [0:199] iboard,
    output logic canMove
);
	always_comb begin
		canMove = 1;
		if(x >= 9) begin
				canMove = 0;
		end
		if(iboard[(y * 10) + x + 1] == 1) begin // Checks right
			canMove = 0;
		end
	end
endmodule

module cDown (
    input integer x,
    input integer y,
    input [0:199] iboard,
    output logic canMove
);
	always_comb begin
		canMove = 1;
		if(y >= 19) begin
				canMove = 0;
		end
		if(iboard[(y * 10) + x + 10] == 1) begin // Checks below
			canMove = 0;	
		end
	end
endmodule

module cCurr(
	input integer x,
	input integer y,
	input [0:199] iboard,
	output logic canMove
);
	always_comb begin
		canMove = 1;
		if(iboard[(y * 10) + x] == 1) begin // Checks @ current
			canMove = 0;
		end
	end
endmodule