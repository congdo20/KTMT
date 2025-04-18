`timescale 1ns/1ps

module Control_Unit_tb;

    reg [6:0] op;
    reg [2:0] funct3;
    reg [6:0] funct7;
    wire RegWrite, MemWrite, ALUSrc, ResultSrc, Branch;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl;

    Control_Unit_Top cu (
        .Op(op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .funct3(funct3),
        .funct7(funct7),
        .ALUControl(ALUControl)
    );

    initial begin
        // add x1, x2, x3: opcode = 0110011, funct3 = 000, funct7 = 0000000
        op = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;

        // lw x1, 0(x2): opcode = 0000011
        op = 7'b0000011;
        #10;

        // sw x1, 0(x2): opcode = 0100011
        op = 7'b0100011;
        #10;

        $finish;
    end
endmodule
