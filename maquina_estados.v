`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:20:00 08/08/2015 
// Design Name: 
// Module Name:    M_Estados 
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
//	Gracias al libro FPGA Prototyping by Verilog Examples de Pong P. Chu, como guia para el codigo
//////////////////////////////////////////////////////////////////////////////////
module M_Estados(
		
		//////////Entradas y Salidas
		input wire clk, reset,
		input wire t_25,t_27,t_30, t_corp,
		output wire notif, aban, alarm,
		output wire [2:0] actual_state
		
    );
	
  
	 //symbolic state declaration
	 localparam [2:0] 
	 
			 s1_inicio=3'b000,
			 s2_temp_25=3'b001,
			 s3_temp_27=3'b010,
			 s4_temp_30=3'b011,
			 s5_temp_corp=3'b100;
			 
			 
			 
	 //signal declaration
	 reg [2:0] state_reg, state_next;
	

			
	 //state register
	 always@(posedge clk, posedge reset)
	 
	 if(reset)
			state_reg<=s1_inicio; ////////se le asigna un estado inicial
	 else
			state_reg<=state_next; //con esto se recorren las variables de estado
	 
	 
		 //Bloque de la maquina de estados, funciona cuando ocurre un cambio
		 always@*
		 begin
			
			///inicializacion de las variables de salida y default
			state_next=state_reg;		
			
			/////Estados///////
				case(state_reg)



					s1_inicio: if(t_25 || t_27 || t_30 || t_corp)  ///estado en el que inicia el sistema, y permite empezar en cualquier estado
										begin										//// si sucede cualquiera de las condiciones
											if(t_25)
													state_next=s2_temp_25;
											else if(t_27)
												
													state_next=s3_temp_27;
												
													else if(t_30)
														state_next=s4_temp_30;
															else if(t_corp)
																state_next=s5_temp_corp;
																	else
																	state_next=s1_inicio;
										end
									
									else
										state_next=s1_inicio;
										
										
										
					s2_temp_25: if(t_27 || t_corp)															////Este estado genera una salida de Notificacion (notif)
											begin														////y evalua si se activa otro estado para cambiar a este o quedarse en el actual
												if(t_30 & t_25)
														state_next=s4_temp_30;
													if(t_corp & t_25)
																state_next=s5_temp_corp;
														else
															state_next=s3_temp_27;
											end
										
									else if(t_25)
											state_next=s2_temp_25;
											else
											state_next=s1_inicio;
										
					
					s3_temp_27: if(t_30 || t_corp)														////Este estado genera una salida de Encender abanico (aban)
										begin 													////y evalua si se activa otro estado para cambiar a este o quedarse en el actual
											if(t_corp)
												begin
													state_next=s5_temp_corp;
												end
											if(t_25)
												begin
													state_next=s2_temp_25;
												end
											state_next=s4_temp_30;
										end
									else if(t_27)
												state_next=s3_temp_27;
											else
												state_next=s1_inicio;
					
					s4_temp_30: if(t_corp)														////Este estado genera una salida de notificar y encender abanico simultaneamente (aban y notif)
											begin 												////y evalua si se activa otro estado para cambiar a este o quedarse en el actual
											if(t_25)
												begin
													state_next=s2_temp_25;
												end
											if(t_27)
												begin
													state_next=s3_temp_27;
												end
											state_next=s5_temp_corp;
										end
									else if (t_30)
												state_next=s4_temp_30;
											else
												state_next=s1_inicio;
												
					s5_temp_corp: if(t_corp)													////Este estado genera una salida independiente de las anteriores y sonar una alarma (alarm)
											begin 													////y evalua si se activa otro estado para cambiar a este o quedarse en el actual
												state_next=s5_temp_corp;
												
												if(t_25 && t_27 && t_30)
													state_next=s5_temp_corp;
											end

										else
											state_next=s1_inicio;
												
												
				endcase		
				//////////////////////////////
			end
			
			
	//Salidas de la maquina de estados /// se evalua para cuales estados se activan y se activan los LEDS
   assign notif 	=	(state_reg==s2_temp_25)? 1'b1 : 1'b0  ||  (state_reg==s4_temp_30)? 1'b1:1'b0 || (state_reg==s5_temp_corp)? 1'b1:1'b0;
	
   assign aban		=	(state_reg==s3_temp_27)? 1'b1:1'b0 ||  (state_reg==s4_temp_30)? 1'b1:1'b0 || (state_reg==s5_temp_corp)? 1'b1:1'b0 ; 	
	
	assign alarm	=	(state_reg==s5_temp_corp)? 1'b1:1'b0;
	
   
	assign actual_state  =   state_reg; 		/////Permite activar las salidas del display segun el estado en que se encuentre la variable


endmodule
