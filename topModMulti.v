`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 04:52:38 PM
// Design Name: 
// Module Name: topModMulti
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


module topModMulti (
    input clk,                   
    input rst,               
    input start,                
    input select,               
    input [7:0] a,              
    input [7:0] b,              
    output reg [15:0] p,  
    output reg done         
//    output [6:0] seg,            
//    output [3:0] anodes         
);

    wire [15:0] seqP;
    wire [15:0] combP;
    wire seqDone;

    //sequential multi inst
    seqMulti seqMulti (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .p(seqP),
        .done(seqDone)
    );

    // Combinational Instance
    comboMulti comboMulti (
        .a(a),
        .b(b),
        .p(combP)
    );

   
    always @(*) begin
        if (select) begin
            // Combinational  
            p = combP;
            done = 1; // Combinational is instantaneous
        end else begin
            // Sequential  
            p = seqP;
            done = seqDone;
        end
    end

//    // 7-segment display logic (Multiplexed)
//    sevenSeg display (
//        .clk(clk),
//        .p(p),
//        .seg(seg),          
//        .anodes(anodes)     
//    );

endmodule
