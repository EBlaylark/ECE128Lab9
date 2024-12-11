`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 04:52:58 PM
// Design Name: 
// Module Name: topModMulti_tb
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


module topModMulti_tb;

    // signals
    reg clk;
    reg rst;
    reg start;
    reg select;
    reg [7:0] a;
    reg [7:0] b;
    wire [15:0] p;
    wire done;
//    wire [6:0] seg;
//    wire [3:0] anodes;

    
    topModMulti uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .select(select),
        .a(a),
        .b(b),
        .p(p),
        .done(done)
//        .seg(seg),
//        .anodes(anodes)
    );

    // Clock 
    always begin
        #5 clk = ~clk; 
    end

    
    initial begin
        
        clk = 0;
        rst = 0;
        start = 0;
        select = 0;
        a = 8'd0;
        b = 8'd0;

       
        rst = 1;
        #10 rst = 0;

        
        a = 8'd8;
        b = 8'd5;
        start = 1;
        select = 0;  // sequential multiplier
        #10 start = 0; // Deassert start after 10 ns

        // Wait for multiplication to finish
        wait(done == 1);
        #10;

        
        
        a = 8'd15;
        b = 8'd3;
        select = 1;  //  combinational 
        #10;

        
        a = 8'd12;
        b = 8'd12;
        start = 1;
        select = 0;  //  sequential 
        #10 start = 0;

        wait(done == 1);
        
        #10;

       
        a = 8'd255;
        b = 8'd2;
        select = 1;  //  combinational 
        #10;
        

        
        $finish;
    end


endmodule
