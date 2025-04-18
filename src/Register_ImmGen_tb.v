`timescale 1ns/1ps

module Register_ImmGen_tb;

    reg clk = 0, rst, we;
    reg [4:0] a1, a2, a3;
    reg [31:0] wd3, instr;
    wire [31:0] rd1, rd2, imm_out;

    // Mô-đun thanh ghi
    Register_File rf (
        .clk(clk),
        .rst(rst),
        .WE3(we),
        .WD3(wd3),
        .A1(a1),
        .A2(a2),
        .A3(a3),
        .RD1(rd1),
        .RD2(rd2)
    );

    // Sinh immediate
    Sign_Extend immgen (
        .In(instr),
        .ImmSrc(1'b0), // 0: I-type, 1: S-type
        .Imm_Ext(imm_out)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 0;
        we = 1;
        a3 = 5'd1;
        wd3 = 32'd100;
        #10 rst = 1;

        a1 = 5'd1;
        a2 = 5'd0;

        instr = 32'b000000000101_00000_000_00001_0010011; // addi x1, x0, 5
        #20;

        $finish;
    end
endmodule
