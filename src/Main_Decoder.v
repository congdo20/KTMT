// module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp);
//     input [6:0]Op;
//     output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
//     output [1:0]ImmSrc,ALUOp;

//     assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011) ? 1'b1 :
//                                                               1'b0 ;
//     assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
//                     (Op == 7'b1100011) ? 2'b10 :    
//                                          2'b00 ;
//     assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011) ? 1'b1 :
//                                                             1'b0 ;
//     assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
//                                            1'b0 ;
//     assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :
//                                             1'b0 ;
//     assign Branch = (Op == 7'b1100011) ? 1'b1 :
//                                          1'b0 ;
//     assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
//                    (Op == 7'b1100011) ? 2'b01 :
//                                         2'b00 ;

// endmodule

module Main_Decoder(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp);

    input [6:0] Op;                       // opcode của lệnh từ instruction
    output RegWrite;                     // cho phép ghi vào thanh ghi
    output ALUSrc;                       // chọn nguồn dữ liệu thứ 2 cho ALU (0: register, 1: immediate)
    output MemWrite;                    // cho phép ghi vào bộ nhớ
    output ResultSrc;                   // chọn nguồn kết quả ghi về thanh ghi (0: ALU, 1: memory)
    output Branch;                      // là nhánh điều kiện (branch)
    output [1:0] ImmSrc;                // chọn loại immediate (00: I-type, 01: S-type, 10: B-type)
    output [1:0] ALUOp;                 // tín hiệu điều khiển cho ALU decoder

    // Ghi vào thanh ghi: với lệnh load (0000011) và lệnh R-type (0110011)
    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011) ? 1'b1 : 1'b0;

    // Chọn loại immediate
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 :    // S-type: store
                    (Op == 7'b1100011) ? 2'b10 :    // B-type: branch
                                         2'b00 ;    // mặc định: I-type

    // ALUSrc = 1 nếu cần dùng immediate: load, store
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011) ? 1'b1 : 1'b0;

    // MemWrite: chỉ bật khi lệnh là store (S-type)
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;

    // ResultSrc: chọn nguồn ghi về thanh ghi: 1 nếu từ bộ nhớ (load)
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0;

    // Branch: bật nếu là lệnh nhánh (branch-type)
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;

    // ALUOp: 2-bit đầu ra để ALU Decoder xác định thao tác cụ thể
    // 10: R-type, 01: branch, 00: các loại còn lại (I-type, load, store...)
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :     // R-type
                   (Op == 7'b1100011) ? 2'b01 :     // branch
                                        2'b00 ;     // mặc định

endmodule
