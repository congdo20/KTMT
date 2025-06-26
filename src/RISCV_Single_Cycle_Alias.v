`include "RISCV_Single_Cycle.v"

module RISCV_Single_Cycle_Alias (
    input clk,
    input rst_n
);

    wire rst;
    assign rst = ~rst_n;

    RISCV_Single_Cycle dut (
        .clk(clk),
        .rst(rst)
    );

endmodule
