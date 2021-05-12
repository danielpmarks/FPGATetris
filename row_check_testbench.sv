module testbench();
timeunit 100ps;

timeprecision 10ps;

logic Clk, Reset, done;


logic [199:0] game_board, new_board;
assign game_board = {180'd0, 10'b0100110010, 10'b1111111111};


RowChecker check(Clk, Reset, game_board, new_board, done);

always begin
    #1 Clk = ~Clk;
end

initial begin
Clk = 1'b0;
Reset = 1'b1;

#4 Reset = 1'b0;

#50 Reset = 1'b1;

#4 Reset = 1'b0;
end

endmodule