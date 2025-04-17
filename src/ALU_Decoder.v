// module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

//     input [1:0]ALUOp;
//     input [2:0]funct3;
//     input [6:0]funct7,op;
//     output [2:0]ALUControl;

    // Method 1 
    // assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
    //                     (ALUOp == 2'b01) ? 3'b001 :
    //                     (ALUOp == 2'b10) ? ((funct3 == 3'b000) ? ((({op[5],funct7[5]} == 2'b00) | ({op[5],funct7[5]} == 2'b01) | ({op[5],funct7[5]} == 2'b10)) ? 3'b000 : 3'b001) : 
    //                                         (funct3 == 3'b010) ? 3'b101 : 
    //                                         (funct3 == 3'b110) ? 3'b011 : 
    //                                         (funct3 == 3'b111) ? 3'b010 : 3'b000) :
    //                                        3'b000;

    // Method 2
//     assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
//                         (ALUOp == 2'b01) ? 3'b001 :
//                         ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11)) ? 3'b001 : 
//                         ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} != 2'b11)) ? 3'b000 : 
//                         ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : 
//                         ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : 
//                         ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 
//                                                                   3'b000 ;
// endmodule

module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

    // Định nghĩa các ngõ vào
    input [1:0] ALUOp;             // Tín hiệu điều khiển từ Control Unit: xác định kiểu thao tác ALU cần làm
    input [2:0] funct3;            // Trường funct3 từ instruction: giúp xác định phép toán cụ thể
    input [6:0] funct7, op;        // funct7 và op (opcode) từ instruction: xác định loại lệnh (R/I-type) và phép toán
    output [2:0] ALUControl;       // Ngõ ra điều khiển ALU (gửi vào ALU)

    // Giải mã ALUControl dựa vào ALUOp, funct3, funct7 và op
    assign ALUControl = 
        (ALUOp == 2'b00) ? 3'b000 : // ALUOp = 00 → lệnh load/store → thực hiện phép cộng (add)

        (ALUOp == 2'b01) ? 3'b001 : // ALUOp = 01 → lệnh nhảy beq → thực hiện phép trừ (sub)

        // ALUOp = 10 → lệnh R-type hoặc I-type → cần xét thêm funct3, funct7 và op

        // Nếu funct3 = 000 và {op[5], funct7[5]} = 2'b11 → lệnh sub (R-type sub)
        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} == 2'b11)) ? 3'b001 :

        // Nếu funct3 = 000 nhưng không phải sub → là add hoặc addi
        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} != 2'b11)) ? 3'b000 :

        // Nếu funct3 = 010 → lệnh slt hoặc slti (so sánh nhỏ hơn có dấu)
        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :

        // Nếu funct3 = 110 → lệnh or hoặc ori
        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :

        // Nếu funct3 = 111 → lệnh and hoặc andi
        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 :

        // Trường hợp mặc định nếu không khớp → chọn add
        3'b000 ;

endmodule
