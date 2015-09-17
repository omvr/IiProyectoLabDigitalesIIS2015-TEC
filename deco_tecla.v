`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:40 09/06/2015 
// Design Name: 
// Module Name:    deco_tecla 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module deco_ud(
		input wire clk,
		input wire [7:0] tecla_d,// tecla_u,
		output reg temp_25,temp_27,temp_30, temp_corp
    );
	 
	reg [7:0] t_d;//, t_u;
	//reg  t_25,t_27,t_30, corp;
//	localparam [7:0]
//			//////////Teclas permitidas
//			
//			rst		=8'h2D,	//b00101101,////2D///R
//			cero		=8'h70,	//b01110000,////70///0
//			dos		=8'h72,	//b01110010,////72///2
//			tres		=8'h7A,	//b01111010,////74///3
//			cinco		=8'h73,	//b01110011,////73///5
//			siete		=8'h6C,	//b01101100,////6C///7
//			C			=8'h21;	//b00100001,////21///C
	

	always@*
		begin///Inicio Always@*
		
		
		//////////////Decenas
			case(tecla_d)
					8'h2D:		t_d	=8'd0;//reset
					8'h7A:		t_d	=8'd1;//tres
					8'h73:		t_d	=8'd2;//cinco
					8'h6C:		t_d	=8'd3;//siete
					8'h21:		t_d	=8'd4;//C
					default:		t_d	=8'd0;
			endcase
			

		end///Fin Always@*
		
		always@(posedge clk)
			begin
		
					if(t_d==8'd2)////Cinco
					begin
						temp_25=1'b1;
					end
					else
						temp_25=1'b0;
					if(t_d==8'd3)////Siete
					begin
						temp_25=1'b1;
						temp_27=1'b1;
					end
					else
						temp_27=1'b0;
					if(t_d==8'd1)/////Tres
					begin
						temp_27=1'b1;
						temp_25=1'b1;
						temp_30=1'b1;
					end
					else
						temp_30=1'b0;
					if(t_d==8'd4)////C
					begin
						temp_corp=1'b1;
						temp_30=1'b1;
						temp_27=1'b1;
						temp_25=1'b1;
					end
					else
						temp_corp=1'b0;
					if(t_d==8'd0)////rst
					begin
						temp_corp=1'b0;
						temp_30=1'b0;
						temp_27=1'b0;
						temp_25=1'b0;
					end
					
					
			end////Fin Always
//	
//		assign temp_25	=t_25;
//		assign temp_27	=t_27;
//		assign temp_30	=t_30;
//		assign temp_corp	=corp;
//		
endmodule
