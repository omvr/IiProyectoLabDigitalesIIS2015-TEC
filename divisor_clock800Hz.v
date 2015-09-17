//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:44 08/09/2015 
// Design Name: 
// Module Name:    div_800kHZ 
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
module div_800kHZ (

///Entradas y Salidas del Divisor
	input wire clk,      
	input wire reset,    
	output reg s1_clk    
    );
	 
	reg [7:0] cuenta;//Bus de datos de 7 bits referente al contador
						  
	 
	always @(posedge clk,posedge reset) //Se procede a realizar el codigo posterior siempre que "clk" o "reset" estén en alto.
		begin
			if (reset) //Si sucede reset, entonces clk=0 y se reinicia la cuenta.
				begin
					s1_clk <= 0;
					cuenta <= 0;
				end 
			else
				begin		
					if (cuenta == 8'd220)
						
						begin                    
							cuenta <= 8'h0;  //Se resetea la cuenta asignandole cero   
							s1_clk <= ~s1_clk; 
						end 
					else 
						cuenta <= cuenta + 1'b1; 
				end
	end
 
endmodule