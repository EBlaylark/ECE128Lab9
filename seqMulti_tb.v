`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 04:20:16 PM
// Design Name: 
// Module Name: seqMulti_tb
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


module seqMulti_tb;

    reg clk, rst, start;
    reg [3:0] A, B;
    wire [7:0] product;
    wire done;

    seqMulti uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .p(p),
        .done(done)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; start = 0; A = 0; B = 0;
        #10 rst = 0;
        #10 A = 4'b1010; B = 4'b0011; start = 1;// 10 * 3 = 30
        #10 start = 0;
        #100 $finish;
    end
endmodule