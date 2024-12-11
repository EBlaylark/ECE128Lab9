`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 05:14:06 PM
// Design Name: 
// Module Name: sevenSeg
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


module sevenSeg (
    input clk,                       
    input [15:0] p,            
    output reg [6:0] seg,            
    output reg [3:0] anodes         
);
    reg [3:0] hex_digits [3:0];      
    reg [1:0] current_digit;         

    // Convert the 16-bit product into 4 hex digits for display
    always @(p) begin
        hex_digits[0] = p[3:0];     // Least significant hex digit
        hex_digits[1] = p[7:4];
        hex_digits[2] = p[11:8];
        hex_digits[3] = p[15:12];   // Most significant hex digit
    end

    
    reg [6:0] seg_encoding [15:0];
    initial begin
        seg_encoding[0]  = 7'b1111110;   // 0
        seg_encoding[1]  = 7'b0110000;   // 1
        seg_encoding[2]  = 7'b1101101;   // 2
        seg_encoding[3]  = 7'b1111001;   // 3
        seg_encoding[4]  = 7'b0110011;   // 4
        seg_encoding[5]  = 7'b1011011;   // 5
        seg_encoding[6]  = 7'b1011111;   // 6
        seg_encoding[7]  = 7'b1110000;   // 7
        seg_encoding[8]  = 7'b1111111;   // 8
        seg_encoding[9]  = 7'b1111011;   // 9
        seg_encoding[10] = 7'b1110111;   // A
        seg_encoding[11] = 7'b0011111;   // b
        seg_encoding[12] = 7'b1001110;   // C
        seg_encoding[13] = 7'b0111101;   // d
        seg_encoding[14] = 7'b1001111;   // E
        seg_encoding[15] = 7'b1000111;   // F
    end

    // Multiplex the 4 digits
    always @(posedge clk) begin
    
    
    
    
        case (current_digit)
            2'b00: begin
                seg <= seg_encoding[hex_digits[0]];  // Display first digit
                anodes <= 4'b1110;                   // Enable first display
            end
            2'b01: begin
                seg <= seg_encoding[hex_digits[1]];  // Display second digit
                anodes <= 4'b1101;                   // Enable second display
            end
            2'b10: begin
                seg <= seg_encoding[hex_digits[2]];  // Display third digit
                anodes <= 4'b1011;                   // Enable third display
            end
            2'b11: begin
                seg <= seg_encoding[hex_digits[3]];  // Display fourth digit
                anodes <= 4'b0111;                   // Enable fourth display
            end
        endcase
    end

    
    always @(posedge clk) begin
        current_digit <= current_digit + 1;
    end
endmodule
