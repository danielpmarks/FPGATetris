//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] DrawX, DrawY,
								input logic [199:0] game_state,
                                input logic [199:0] piece_layer,
                       output logic [7:0]  Red, Green, Blue );
    
    //logic block_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int  X;
    logic block_on;
    
    //assign Size = Ball_size;
	 
    logic board_block, piece_block;
    logic [9:0] game_row, piece_row;
	tetris_row_map map(game_row, X, piece_row, board_block, piece_block);


    //Assign the correct row based on the cursor position
    always_comb begin: row_calculation
        if(DrawY < 70)begin
            game_row = game_state[199:190];
            piece_row = piece_layer[199:190];
        end
        else if(DrawY < 90)
        begin
            game_row = game_state[189:180];
            piece_row = piece_layer[189:180];
        end
        else if(DrawY < 110)
        begin
            game_row = game_state[179:170];
            piece_row = piece_layer[179:170];
        end
        else if(DrawY < 130)
        begin
            game_row = game_state[169:160];
            piece_row = piece_layer[169:160];
        end
        else if(DrawY < 150)
        begin
            game_row = game_state[159:150];
            piece_row = piece_layer[159:150];
        end
        else if(DrawY < 170)
        begin
            game_row = game_state[149:140];
            piece_row = piece_layer[149:140];
        end
        else if(DrawY < 190)
        begin
            game_row = game_state[139:130];
            piece_row = piece_layer[139:130];
        end
        else if(DrawY < 210)
        begin
            game_row = game_state[129:120];
            piece_row = piece_layer[129:120];
        end
        else if(DrawY < 230)
        begin
            game_row = game_state[119:110];
            piece_row = piece_layer[119:110];
        end
        else if(DrawY < 250)
        begin
            game_row = game_state[109:100];
            piece_row = piece_layer[109:100];
        end
        else if(DrawY < 270)
        begin
            game_row = game_state[99:90];
            piece_row = piece_layer[99:90];
        end
        else if(DrawY < 290)
        begin
            game_row = game_state[89:80];
            piece_row = piece_layer[89:80];
        end
        else if(DrawY < 310)
        begin
            game_row = game_state[79:70];
            piece_row = piece_layer[79:70];
        end
        else if(DrawY < 330)
        begin
            game_row = game_state[69:60];
            piece_row = piece_layer[69:60];
        end
        else if(DrawY < 350)
        begin
            game_row = game_state[59:50];
            piece_row = piece_layer[59:50];
        end
        else if(DrawY < 370)
        begin
            game_row = game_state[49:40];
            piece_row = piece_layer[49:40];
        end
        else if(DrawY < 390)
        begin
            game_row = game_state[39:30];
            piece_row = piece_layer[39:30];
        end
        else if(DrawY < 410)
        begin
            game_row = game_state[29:20];
            piece_row = piece_layer[29:20];
        end
        else if(DrawY < 430)
        begin
            game_row = game_state[19:10];
            piece_row = piece_layer[19:10];
        end
        else
        begin
            game_row = game_state[9:0];
            piece_row = piece_layer[9:0];
        end
    end
	
    always_comb begin : location_conversion
        X = DrawX;
        if(DrawX < 10'd400 && DrawX >= 10'd200 && DrawY >= 10'd50 && DrawY < 10'd450)
        begin
            X = DrawX - 10'd200;
            if(piece_block == 1'b1)
            begin
                Red = 8'h33;
                Green = 8'h33;
                Blue = 8'hff;
            end
            else if(board_block == 1'b1)
            begin
                Red = 8'he6;
                Green = 8'h73;
                Blue = 8'h00;
            end
            else
            begin
                Red = 8'h00; 
                Green = 8'h00;
                Blue = 8'h00;
            end
        end
        else if ((((DrawX < 10'd200 && DrawX > 10'd195) || (DrawX < 10'd405 && DrawX >= 10'd400)) && (DrawY > 10'd45 && DrawY < 10'd455))
                || ((DrawY < 10'd50 && DrawY > 10'd45) || (DrawY >= 10'd450 && DrawY < 10'd455)) && (DrawX > 10'd195 && DrawX < 405)) begin
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;
        end
        else
        begin
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h00;
        end
    end

    /*always_comb
    begin:RGB_Display
        if ((block_on == 1'b1)) 
        begin 
            
        end
        else
        begin
           
        end  
    end */
    
endmodule
