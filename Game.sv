module Game(input logic Clk,Reset,      
            input logic [7:0] key,
            output logic [199:0] game_board,piece_layer, 
            output logic game_over);

    longint unsigned counter, next_counter;
    longint unsigned threshold, next_threshold;
    logic [199:0] next_game_board, row_check_board, next_row_check_board, checked_board, next_piece_layer, new_piece_layer, spawn_piece_layer;
    logic [29:0] bottom_board, bottom_row_board;
	logic start_row_check, next_start_row_check, reset_row_check, check_done;
	integer next_pos_y, next_pos_x;
	
    integer piece_idx,next_piece_idx, rot, next_rot, right_rot, left_rot;
		integer signed pos_x,pos_y;
	 
    assign bottom_board = game_board[199 -: 30];
    assign bottom_row_board = row_check_board[199 -: 30];

    logic [3:0] piece_x;
    logic [4:0] piece_y;
    logic [7:0] y_shift;
    logic [3:0] x_shift;

    logic [15:0] piece, next_piece, new_piece;

    enum logic [2:0] {Wait, Play, Game_Over} game_state, next_game_state;
    enum logic [1:0] {Falling, Check_Rows, Stall} play_state, next_play_state;

    

    logic key_down, next_key_down;
	 
	logic down_en, left_en, right_en, down_flag, rot_right_en, rot_left_en;

    logic [15:0] rot_left_piece, rot_right_piece;

    integer score, new_score, row_count;
	 
	
	
	piecemaker choose_piece(piece_idx, rot, new_piece);
    piecemaker right_rotation(piece_idx, right_rot, rot_right_piece);
    piecemaker left_rotations(piece_idx, left_rot, rot_left_piece);

    MoveChecker checkCurPiece(piece, game_board, pos_x, pos_y, left_en, down_en, right_en, );
	MoveChecker checkRotRightPiece(rot_right_piece, game_board, pos_x, pos_y, , , , rot_right_en);
	MoveChecker checkRotLeftPiece(rot_left_piece, game_board, pos_x, pos_y, , , , rot_left_en);
	 
    RowChecker checkRow(Clk, reset_row_check, game_board, checked_board, check_done, row_count);

    always_comb begin: Y_Shift_Lookup_Table
        x_shift = next_pos_x;
        new_piece_layer = ({next_piece[15:12], 6'd0, next_piece[11:8], 6'd0, next_piece[7:4], 6'd0, next_piece[3:0], 6'd0, 160'd0} >> x_shift) >> y_shift;
        spawn_piece_layer = (({new_piece[15:12], 6'd0, new_piece[11:8], 6'd0, new_piece[7:4], 6'd0, new_piece[3:0], 6'd0, 160'd0} >> 3) << 10);
        //piece_layer = ({game_piece[15:12], 6'd0, game_piece[11:8], 6'd0, game_piece[7:4], 6'd0, game_piece[3:0], 6'd0, 160'd0});
        
        right_rot = rot < 3 ? rot + 1 : 0;
        left_rot = rot > 0 ? rot - 1 : 3;

        unique case(next_pos_y)
            5'd1: y_shift = 8'd10;
            5'd2: y_shift = 8'd20;
            5'd3: y_shift = 8'd30;
            5'd4: y_shift = 8'd40;
            5'd5: y_shift = 8'd50;
            5'd6: y_shift = 8'd60;
            5'd7: y_shift = 8'd70;
            5'd8: y_shift = 8'd80;
            5'd9: y_shift = 8'd90;
            5'd10: y_shift = 8'd100;
            5'd11: y_shift = 8'd110;
            5'd12: y_shift = 8'd120;
            5'd13: y_shift = 8'd130;
            5'd14: y_shift = 8'd140;
            5'd15: y_shift = 8'd150;
            5'd16: y_shift = 8'd160;
            5'd17: y_shift = 8'd170;
            5'd18: y_shift = 8'd180;
            5'd19: y_shift = 8'd190;
            5'd20: y_shift = 8'd200;
            default: y_shift = 8'd0;
        endcase

        if(score < 5) begin
            threshold = 64'd100000000;
        end
        else if (score < 10) begin
            threshold = 64'd75000000;
        end
        else if (score < 15) begin
            threshold = 64'd50000000;
        end
        else if (score < 20) begin
            threshold = 64'd25000000;
        end
        else if (score < 25) begin
            threshold = 64'd20000000;
        end
        else if (score < 30) begin
            threshold = 64'd15000000;
        end
        else begin
            threshold = 64'd10000000;
        end
    end

    always_ff @ (posedge Clk or posedge Reset) 
    begin
        if(Reset)begin
            counter <= 64'd0;
            
            game_state <= Wait;
            game_board <= 200'd0;
            piece_layer <= 20'd0;
            pos_x <= 3;
            pos_y <= 0;
            piece_idx <= 0;
            rot <= 0;
            score <= 0;
        end
		  else
		  begin
            game_board <= next_game_board;
            
            pos_y <= next_pos_y;
				pos_x <= next_pos_x;
            counter <= next_counter;
           
				game_state <= next_game_state;
            piece <= next_piece;
            piece_layer <= next_piece_layer;
            key_down <= next_key_down;
            play_state <= next_play_state;
            row_check_board <= next_row_check_board;
            start_row_check <= next_start_row_check;
            piece_idx <= next_piece_idx;
            rot <= next_rot;
            score <= new_score;
		  end

    end
	 
	 always_comb begin
		next_game_board = game_board;
		next_counter = 0;
		next_pos_y = 0;
		next_pos_x = 3;
		next_threshold = threshold;
        next_game_state = game_state;
		game_over = 1'b0;
        next_piece_layer = piece_layer;
        next_key_down = key_down;
        
		next_row_check_board = row_check_board;
        next_play_state = play_state;
		next_start_row_check = 1'b0;
		reset_row_check = 1'b0;
		next_piece_idx = piece_idx;
		next_rot = rot;
        next_piece = piece;
        new_score = score;
        if(key == 16'h00)
            next_key_down = 1'b0;

        

        unique case(game_state)
            Wait: begin
                if(key == 16'h40)
                begin
                    next_game_state = Play;
                    next_threshold = 64'd100000000;
                    next_pos_y = 0;
                    next_pos_x = 3;
                    
                    next_piece_layer = new_piece_layer;
                    next_play_state = Falling;
                    next_piece = new_piece;
                end
            end
            Play: begin
                unique case(play_state)
                    Falling: begin
                        next_counter = counter + 1;
                        next_game_board = game_board;
                        
                        next_pos_y = pos_y;
                        next_pos_x = pos_x;
                        
                        if(key_down == 1'b0)
                        begin
                            if(key == 16'h80 && left_en) begin
                            next_piece_layer = piece_layer << 1;
                            next_pos_x = pos_x - 1;
                            next_key_down = 1'b1;
                            end 
                            else if(key == 16'h79 && right_en) begin
                                next_piece_layer = piece_layer >> 1;
                                next_pos_x = pos_x + 1;
                                next_key_down = 1'b1;
                            end
                            else if (key == 16'h81 && down_en) begin
                                next_piece_layer = piece_layer >> 10;
                                next_pos_y = pos_y + 1;
                                next_key_down = 1'b1;
                                next_counter = 64'd0;
                            end
                            else if (key == 16'h82 && rot_right_en) begin

                                next_rot = rot < 3 ? rot + 1 : 0;
                                next_piece = new_piece;
                                next_piece_layer = new_piece_layer;
                                next_key_down = 1'b1;
                            end
                            else if (key == 16'h29 && rot_left_en) begin
                                next_rot = rot > 0 ? rot - 1 : 3;
                                next_piece = new_piece;
                                next_piece_layer = new_piece_layer;
                                next_key_down = 1'b1;
                            end
                        end

                        if(counter > threshold)
                            begin
                            next_counter = 64'd0;
                            // MOVE PIECE DOWN
                            next_pos_y = pos_y + 1;
                            next_piece_layer = piece_layer >> 10;
                            if(!down_en) begin
                                if(pos_y == -1) begin
                                    next_game_state = Game_Over;
                                end
                                next_game_board = game_board | piece_layer;
                        
                                next_start_row_check = 1'b1;
                                next_play_state = Check_Rows;
                                next_row_check_board = 200'd0;
                                if(piece_idx < 6)
                                    next_piece_idx = piece_idx+1;
                                else
                                    next_piece_idx = 0;
                                next_rot = 0;
                            end
                        end
                    end
                    
                   
                    Check_Rows: begin 
                        
                    unique case(start_row_check)
                        1'b1: begin
                                reset_row_check = 1'b1;
                                next_start_row_check = 1'b0;
                                        
                        end
                        1'b0: begin
                            if(check_done) begin
                                next_game_board = checked_board;
                                next_piece_layer = spawn_piece_layer;
                                next_play_state = Falling;
								next_piece = new_piece;
                                new_score = score + row_count;
                                next_pos_y = -1;
                                next_pos_x = 3;
                            end
                                
                        end
                    endcase
                    end
                endcase
                end

                Game_Over: begin
                    game_over = 1'b1;
                end
                
                
			endcase
		  
	 end

endmodule