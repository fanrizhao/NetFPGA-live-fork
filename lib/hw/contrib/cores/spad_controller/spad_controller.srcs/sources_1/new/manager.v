`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2017 00:01:15
// Design Name: 
// Module Name: spad_manager
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


module spad_manager(
    input clk,
    input reset,
    
    output LatchSpad,
    output ResetSpad,
    output [2:0] RowSelect,
    output [5:0] ColSelect,
    output isSecondHalfOfRows,
    input [7:0] PixelIn0,
    input [7:0] PixelIn1,
    input [7:0] PixelIn2,
    input [7:0] PixelIn3,
    
    output [7:0] PixelOut0,
    output [7:0] PixelOut1,
    output [7:0] PixelOut2,
    output [7:0] PixelOut3,
    output ReadEnable
    );
    

    reg [3 : 0] read_cycle_counter;
    reg clock_divider;
    wire read_data;
    
    controller controller(
        .clk(clock_divider),
        .reset(reset),
        .LatchSpad(LatchSpad),
        .ResetSpad(ResetSpad),
        .RowSelect(RowSelect),
        .ColSelect(ColSelect),
        .ReadData(read_data)
    );
    
    assign PixelOut0 = PixelIn0;
    assign PixelOut1 = PixelIn1;
    assign PixelOut2 = PixelIn2;
    assign PixelOut3 = PixelIn3;
    
    assign isSecondHalfOfRows = read_cycle_counter[3];
    assign ReadEnable = read_cycle_counter[2];
    
    initial begin
        clock_divider = 0;
    end
    
    always @(posedge clk) begin    
        clock_divider = ~clock_divider;
        
        if(reset | ~read_data) begin
            read_cycle_counter = 0;
        end else begin
            read_cycle_counter = read_cycle_counter + 1;
        end
    end

endmodule
