//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:38:00 08/08/2015 
// Design Name: 
// Module Name:    Divisor_Clock
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
//	Gracias a esta pagina por el modelo a seguir para el divisor de frecuencia:
//	http://es.edaboard.com/topic-1696772.0.html
//////////////////////////////////////////////////////////////////////////////////
module Divisor (

	///Entradas y Salidas del Divisor
	input wire clk,       
	input wire reset,     
	output reg s_clk      
    );
	 
	reg [18:0] cuenta; //Bus de datos de 20 bits referente al contador
							
	 
	always @(posedge clk,posedge reset) //Se procede a realizar el codigo posterior siempre que "clk" o "reset" estén en alto.
		begin
			if (reset) //Si sucede reset, entonces clk=0 y se reinicia la cuenta.
				begin
					s_clk <= 0;
					cuenta <= 0;
				end 
			else 
				begin		
					if (cuenta == 19'd499999)
						
						begin                    
							cuenta <= 19'h0;  //Se resetea la cuenta asignandole cero   
							s_clk <= ~s_clk; 
						end 
					else 
						cuenta <= cuenta + 1'b1;
				end
		end
 
endmodule