`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:49 09/09/2015 
// Design Name: 
// Module Name:    top_proyc2 
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
module top_proyc2(
		input wire clk, reset,
		input wire ps2d, ps2c,rx_en,
		output wire rx_end, T25,T27,T30,Tcorp, z,
		output wire notif,aban,alarm,clock,a,b,c,d,e,f,g,dp,d0,d1,d2,d3, //
		wire [2:0]	actual_state,
		output wire [7:0] key_out, dec//, uni
    );

	wire [7:0] ckey_out, cdec;//, cuni;
	wire end_rx, t25,t27,t30,tcorp;
// Instantiate the module
ps2 kb (
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .rx_en(rx_en), 
    .z(z), 
    .rx_done_tick(end_rx), 
    .dout(ckey_out)
    );

// Instantiate the module
filtro_tecla filtro (
    .reset(reset), 
    .clk(clk), 
    .d_tecla(ckey_out), 
 //   .rx_done(end_rx), 
    .t_dec(cdec)
 //   .t_uni(cuni)
    );


// Instantiate the module
deco_ud temperatura (
    .clk(clk), 
   // .tecla_u(cuni), 
    .tecla_d(cdec), 
    .temp_25(t25), 
    .temp_27(t27), 
    .temp_30(t30), 
    .temp_corp(tcorp)
    );

//Proyecto Corto 1

// Instantiate the module
M_Estados FSM (
    .clk(s_clk), 
    .reset(reset), 
    .t_25(t25), 
    .t_27(t27), 
    .t_30(t30), 
    .t_corp(tcorp), 
    .notif(notif), 
    .aban(aban), 
    .alarm(alarm), 
    .actual_state(actual_state)
    );
	 
	// Instantiate the module
Divisor Div_clk (
    .clk(clk), 
    .reset(reset), 
    .s_clk(s_clk)
    );

// Instantiate the module
display7seg Display (
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .e(e), 
    .f(f), 
    .g(g), 
    .dp(dp), 
    .d0(d0), 
    .d1(d1), 
    .d2(d2), 
    .d3(d3), 
    .clk(s1_clk), 
    .actual_state(actual_state)
    );


// Instantiate the module
div_800kHZ div_800khz (
    .clk(clk), 
    .reset(reset), 
    .s1_clk(s1_clk)
    );

//Proyecto Corto 1

//Asignacion de cables entre modulos
	assign dec			=cdec;
	assign key_out		=ckey_out;
	assign rx_end		=end_rx;


///Salidas Teclas
	assign T25		=	t25;
	assign T27		=	t27;
	assign T30		=	t30;
	assign Tcorp	=	tcorp;
	



endmodule