module piecemaker(
	input integer ptype, state, 
	output logic [0:15] npiece
);

logic [0:63] stateArray;

always_comb begin
	stateArray = {64'h0000000000000000};
	unique case(ptype)
		0: stateArray = {64'h0f0022220f002222}; // 4-Long				0
		1: stateArray = {64'h0e404c4004e04640}; // t-Shape				1
		2: stateArray = {64'h0e80c44002e04460}; // Left hang L		2
		3: stateArray = {64'h0e2044c008e06440}; // Right hang L		3
		4: stateArray = {64'h06c08c4006c08c40}; // Right face bolt	4
		5: stateArray = {64'h0c6026400c602640}; // Left face bolt	5
		6: stateArray = {64'h0660066006600660}; // Square				6
	endcase
	npiece = stateArray[(state * 16) +: 16];
end 

endmodule 