`timescale 1ns/1ps

module Single_Cycle_Top_Tb2;

    reg clk = 1, rst;

    // Kết nối với top module
    Single_Cycle_Top uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk; // xung clock 10ns

    initial begin
        rst = 0;
        #10 rst = 1;
        #1000;
        $finish;
    end
endmodule
