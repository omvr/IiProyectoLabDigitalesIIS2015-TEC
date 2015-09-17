//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:03:39 08/09/2015 
// Design Name: 
// Module Name:    display7seg 
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

module display7seg(
// Creacion de variables de entrada
output wire a, b, c, d, e, f, g, dp,d0,d1,d2,d3,
input wire clk,
input wire [2:0] actual_state 
 );

reg count;

// Ciclo del contador para hacer cambio entre displays
always @(posedge clk)
 begin
   count <= count + 1'b1;
 end

reg d0show,d3show;
reg [6:0]show_dis;
/// logica muestra los estados de la maquina
always @(count,actual_state)
begin
  case(count) 
    
   1'b0 :  
    begin
	 d0show=0;
	 d3show=1;
	 if (actual_state ==3'b000)
	   show_dis = 7'b0000001; // muestra el estado 0
			 else if (actual_state ==3'b001)
		show_dis = 7'b1001111; // muestra el estado 1
			 else if (actual_state ==3'b010)
		show_dis = 7'b0010010; // muestra el estado 2
			 else if (actual_state ==3'b011)
		show_dis = 7'b0000110; // muestra el estado 3
			 else if (actual_state ==3'b100)
		show_dis = 7'b1001100;// muestra el estado 4
          else
        show_dis =7'b1111111; /// /		no mostrar nada en display		 
    end
    
   1'b1: 
    begin
	 d0show=1;
	 d3show=0;	 
	 if (actual_state==3'b001)
      show_dis = 7'b1110001; //L = Low (temperatura baja)
			 else if (actual_state ==3'b010)
		show_dis = 7'b1001000; //H = High (temperatura alta)
			 else if (actual_state ==3'b011)
		show_dis = 7'b0011000; // P = Peligro(temperatura extrema)
			 else if (actual_state ==3'b100) 
		show_dis = 7'b0110001; //C  = (temperatura corporal)

      else
        show_dis =7'b1111111; /// /	 no mostrar nada en display		
	 end
  endcase
  end
// Indicacion de los displays encendidos y apagados
assign dp = 1'b1;
assign d2 = 1'b1;
assign d1 = 1'b1;
assign d0=d0show;
assign d3=d3show;
// Asignacion de los valores en el display
assign {a,b,c,d,e,f,g} =  show_dis;

endmodule