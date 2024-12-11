`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2024 04:19:51 PM
// Design Name: 
// Module Name: seqMulti
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


module seqMulti(
    input clk,
    input rst,
    input start,
    input [3:0] a,
    input [3:0] b, 
    output reg [7:0] p,
    output reg done
);

    // states
    parameter S0_idle = 0, S1_multiply = 1, S2_update_result = 2, S3_done = 3;
    reg [7:0] partial_product;
    reg [7:0] multiplicand;
    reg [3:0] shift_count;
    reg [3:0] operand_bb;
    reg [1:0] CS, NS;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            CS <= S0_idle; //reset current state
        else
            CS <= NS; //transition  next state
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            partial_product <= 8'b0;
            shift_count <= 4'b0;
            multiplicand <= 8'b0;
            operand_bb <= 4'b0;
            p <= 8'b0;
            done <= 0;
        end else begin
            case (CS)
                S0_idle: begin
                    if (start) begin
                        partial_product <= 8'b0;
                        multiplicand <= {4'b0, a};
                        operand_bb <= b;
                        shift_count <= 4'b0;
                        done <= 0;
                        NS = S1_multiply;
                    end else begin
                        NS = S0_idle;
                    end
                end
                S1_multiply: begin
                    if (shift_count < 4) begin
                        if (operand_bb[0]) 
                            partial_product <= partial_product + multiplicand;
                        multiplicand <= multiplicand << 1;
                        operand_bb <= operand_bb >> 1;
                        shift_count <= shift_count + 1;
                        NS = S1_multiply;
                    end else begin
                        NS = S2_update_result;
                    end
                end
                S2_update_result: begin
                    p <= partial_product;
                    done <= 1;
                    NS = S3_done;
                end
                S3_done: begin
                    NS = S0_idle;
                end
            endcase
        end
    end
endmodule
