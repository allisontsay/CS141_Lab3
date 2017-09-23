`timescale 1ns / 1ps
`default_nettype none //helps catch typo-related bugs
//////////////////////////////////////////////////////////////////////////////////
// 
// CS 141 - Fall 2016
// Module Name:    alu 
// Author(s): [[your name here]]
// Description: CS 141 lab 2
//
//
//////////////////////////////////////////////////////////////////////////////////
`include "alu_defines.v"

module alu(X,Y,Z,op_code, equal, overflow, zero);

	//port definitions - customize for different bit widths
	input  wire [31:0] X;
	input  wire [31:0] Y;
	output wire [31:0] Z;
	input  wire [3:0] op_code;
	
	
	output wire equal, overflow, zero;
	
	wire [31:0] and_out, or_out, xor_out, nor_out, add_out, sub_out, slt_out, srl_out, sll_out, sra_out, reserved_val;
	
	//functional blocks
	
   //YOUR CODE HERE - remember to use a separate file for each module you create
	assign and_out = X & Y ;
	assign or_out = X | Y ;
	assign xor_out = X ^ Y ;
	assign nor_out = ~(X | Y);
	assign reserved_val = 32'b00000000000000000000000000000000;

	//assign equal = (X*Y) | (~X*~Y);
	
	assign equal = &(X^~Y);
	assign zero = ~(Z);
	//assign zero = XY;
	
	
	//instantiate adder
	adder_32bit add32(.X(X), .Y(Y), .sum(add_out), .cout(overflow));
	
	//instantiate subtractor
	sub_32bit sub32(.X(X), .Y(Y), .diff(sub_out), .cout(cout), .invert(invert), .two_comp(two_comp), .overflow(overflow));
	
	//instantiate MUX
	mux16to1 BIG_MUX(.A(and_out),.B(or_out),.C(xor_out),.D(nor_out),.E(reserved_val), .F(add_out),.G(sub_out),.H(slt_out),.I(srl_out),.J(sll_out),.K(sra_out),.L(reserved_val),.M(reserved_val),.N(reserved_val),.O(reserved_val),.P(reserved_val),.switch(op_code), .out(Z));

	
	//assign ALU_OP_ADD = add(X,Y,0,0,0);
	
	/*assign ALU_OP_SUB = 
	assign ALU_OP_SLT = 
	assign ALU_OP_SRL =
	assign ALU_OP_SLL =
	assign ALU_OP_SRA =*/
	
	
endmodule
`default_nettype wire //some Xilinx IP requires that the default_nettype be set to wire
