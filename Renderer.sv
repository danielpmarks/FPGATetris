module renderer (
	input Clk, Reset,
	input logic[7:0] keycode,
	output logic [7:0] R,G,B,
	output logic hs,vs,VGA_Clk,blank,sync,
	input logic [199:0] game_state, 
	input logic [199:0] piece_layer
);

	

	logic frame_clk, pixel_clk;
	logic [9:0] Ball_x, Ball_y, Ball_size, Draw_x, Draw_y; 
	logic [7:0] Red,Green,Blue;
	
		

	
	vga_controller VGA(.Clk(Clk),.Reset(Reset),
		.hs(hs),.vs(frame_clk), .blank(blank),.sync(sync), .pixel_clk(pixel_clk), .DrawX(Draw_x),.DrawY(Draw_y));
	
	color_mapper color(.DrawX(Draw_x), .DrawY(Draw_y),.Red(Red),.Green(Green),.Blue(Blue), .game_state(game_state),.piece_layer(piece_layer));
	
	assign vs = frame_clk;
	assign R = Red;
	assign G = Green;
	assign B = Blue;
	assign VGA_Clk = pixel_clk;
	
endmodule