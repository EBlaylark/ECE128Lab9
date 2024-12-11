`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 04:46:17 PM
// Design Name: 
// Module Name: comboMulti_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module comboMulti_tb;

    reg [3:0] A, B;
    wire [7:0] product;

    comboMulti uut (
        .a(a),
        .b(b),
        .p(p)
    );

    initial begin
        A = 0; B = 0;
        #10 A = 4'b1010; B = 4'b0100; //10 * 4 = 40
        #10 A = 4'b1111; B = 4'b1111; //15 * 15 = 225
        #10 $finish;
    end
endmodule
