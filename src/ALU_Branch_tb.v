`timescale 1ns/1ps

module ALU_Branch_tb;

    reg [31:0] A, B;
    reg [2:0] alu_ctrl;
    wire [31:0] result;
    wire zero, neg, carry, ovf;

    // Mô-đun ALU
    ALU alu (
        .A(A),
        .B(B),
        .ALUControl(alu_ctrl),
        .Result(result),
        .Zero(zero),
        .Negative(neg),
        .Carry(carry),
        .OverFlow(ovf)
    );

    initial begin
        A = 10; B = 5; alu_ctrl = 3'b000; // ADD
        #10;
        A = 10; B = 3; alu_ctrl = 3'b110; // SUB
        #10;
        A = 10; B = 10; alu_ctrl = 3'b000; // ADD -> Zero flag off
        #10;
        A = 5; B = 5; alu_ctrl = 3'b110; // SUB -> Zero flag on
        #10;

        $finish;
    end
endmodule
