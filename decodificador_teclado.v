`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ITCR
// Engineer: Luis Carlos Espinoza Ortiz
// 
// Create Date:    15:11:41 09/03/2015 
// Design Name: Validacion de tecla
// Module Name:    validar_tecla 
// Project Name: Proyecto Corto 2
// Target Devices: Nexys 3
// Tool versions: ISE 14.7
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module filtro_tecla(
		input wire reset , clk,
		input wire [7:0] d_tecla,
		output reg [7:0] t_dec
    );
	 

		
		///señales
		reg [2:0]	state_reg, state_next;
		
		////Estados
		localparam [2:0]
			s0_espera		=2'b00,
			s1_reset			=2'b01;

			 
		localparam [7:0]
			//////////Teclas permitidas
			rst		=8'b00101101,////2D   /// R
			//teclabrk	=8'b11110000,////F0
			cero		=8'b01110000,////70
			dos		=8'b01110010,////72
			tres		=8'b01111010,////7A
			cinco		=8'b01110011,////73
			siete		=8'b01101100,////6C
			C			=8'b00100001;////21

			
			
		// state register
		always@(posedge clk, posedge reset)
		
		 if(reset)
		 begin
	
				state_reg 	<= s0_espera; ////////se le asigna un estado inicial
			

				
			end
		 else
		 begin
				state_reg 	<= state_next; //con esto se recorren las variables de estado
		end
		
		
		//Bloque de la maquina de estados, funciona cuando ocurre un cambio
		 always@*
		 begin///////inicio always

			///inicializacion de las variables de salida y default
			state_next	=state_reg;	
			t_dec	=8'b00000000;

									
			/////Estados///////
				case(state_reg)
					/////////////FILTRO DE TECLA LIBERADA
					
					s0_espera:
						begin

							if(d_tecla==siete | d_tecla==cero | d_tecla==cinco | d_tecla==C)
							begin
								t_dec=d_tecla;
								state_next=s0_espera;
							end
							else
								state_next=s0_espera;
							if(d_tecla==rst)
							begin
								state_next=s1_reset;
							end
							else
								state_next=s0_espera;
						end
						/////////////FILTRO DE TECLA LIBERAD
						s1_reset:
							begin
								t_dec	=8'b00000000;
								state_next = s0_espera;
							end
						/////////////Default
					default: 
						begin 
							
							state_next = s0_espera;
						
						end
				
						/////////////Default
			/////Estados///////		
				endcase
//////////////////////END ALWAYS
		end

endmodule
