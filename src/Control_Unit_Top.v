// `include "ALU_Decoder.v"
// `include "Main_Decoder.v"

// module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

//     input [6:0]Op,funct7;
//     input [2:0]funct3;
//     output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
//     output [1:0]ImmSrc;
//     output [2:0]ALUControl;

//     wire [1:0]ALUOp;

//     Main_Decoder Main_Decoder(
//                 .Op(Op),
//                 .RegWrite(RegWrite),
//                 .ImmSrc(ImmSrc),
//                 .MemWrite(MemWrite),
//                 .ResultSrc(ResultSrc),
//                 .Branch(Branch),
//                 .ALUSrc(ALUSrc),
//                 .ALUOp(ALUOp)
//     );

//     ALU_Decoder ALU_Decoder(
//                             .ALUOp(ALUOp),
//                             .funct3(funct3),
//                             .funct7(funct7),
//                             .op(Op),
//                             .ALUControl(ALUControl)
//     );


// endmodule



// Bao gồm định nghĩa của hai module phụ
`include "ALU_Decoder.v"
`include "Main_Decoder.v"

// Module điều khiển cấp cao
module Control_Unit_Top(
    Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch,
    funct3, funct7, ALUControl
);

    // Đầu vào
    input [6:0] Op, funct7;       // Mã opcode và funct7 từ lệnh
    input [2:0] funct3;           // Trường funct3 từ lệnh

    // Đầu ra điều khiển
    output RegWrite;              // Ghi thanh ghi hay không
    output ALUSrc;                // Chọn nguồn B cho ALU (từ thanh ghi hay hằng số)
    output MemWrite;              // Ghi bộ nhớ hay không
    output ResultSrc;             // Chọn kết quả trả về: từ ALU hay từ bộ nhớ
    output Branch;                // Có phải lệnh rẽ nhánh không
    output [1:0] ImmSrc;          // Chọn cách mở rộng hằng số (I-type, S-type, B-type,...)
    output [2:0] ALUControl;      // Tín hiệu điều khiển ALU (tương ứng phép toán)

    wire [1:0] ALUOp;             // Tín hiệu trung gian từ Main_Decoder đến ALU_Decoder

    // Bộ giải mã chính (Main Decoder): dựa vào Op để sinh tín hiệu điều khiển
    Main_Decoder Main_Decoder(
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)             // Tín hiệu này sẽ dùng để chọn loại phép toán trong ALU
    );

    // Bộ giải mã ALU (ALU Decoder): dựa vào ALUOp, funct3, funct7 để sinh ALUControl
    ALU_Decoder ALU_Decoder(
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );

endmodule
