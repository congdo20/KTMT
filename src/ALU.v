// module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

//     input [31:0]A,B;
//     input [2:0]ALUControl;
//     output Carry,OverFlow,Zero,Negative;
//     output [31:0]Result;

//     wire Cout;
//     wire [31:0]Sum;

//     assign {Cout,Sum} = (ALUControl[0] == 1'b0) ? A + B :
//                                           (A + ((~B)+1)) ;
//     assign Result = (ALUControl == 3'b000) ? Sum :
//                     (ALUControl == 3'b001) ? Sum :
//                     (ALUControl == 3'b010) ? A & B :
//                     (ALUControl == 3'b011) ? A | B :
//                     (ALUControl == 3'b101) ? {{31{1'b0}},(Sum[31])} : {32{1'b0}};
    
//     assign OverFlow = ((Sum[31] ^ A[31]) & 
//                       (~(ALUControl[0] ^ B[31] ^ A[31])) &
//                       (~ALUControl[1]));
//     assign Carry = ((~ALUControl[1]) & Cout);
//     assign Zero = &(~Result);
//     assign Negative = Result[31];

// endmodule

module ALU(A, B, Result, ALUControl, OverFlow, Carry, Zero, Negative);

    // Khai báo ngõ vào và ngõ ra
    input [31:0] A, B;             // 2 toán hạng đầu vào 32-bit
    input [2:0] ALUControl;        // Tín hiệu điều khiển ALU
    output Carry, OverFlow, Zero, Negative;  // Cờ trạng thái
    output [31:0] Result;          // Kết quả đầu ra 32-bit

    wire Cout;                     // Bit nhớ (carry out)
    wire [31:0] Sum;               // Kết quả cộng hoặc trừ

    // Thực hiện cộng hoặc trừ tùy theo ALUControl[0]
    // ALUControl[0] = 0 → cộng, = 1 → trừ (dùng bù 2)
    assign {Cout, Sum} = (ALUControl[0] == 1'b0) ? A + B :
                                               (A + ((~B) + 1));  // A - B

    // Chọn kết quả cuối cùng theo ALUControl
    assign Result = (ALUControl == 3'b000) ? Sum :                // ADD
                    (ALUControl == 3'b001) ? Sum :                // SUB
                    (ALUControl == 3'b010) ? A & B :              // AND
                    (ALUControl == 3'b011) ? A | B :              // OR
                    (ALUControl == 3'b101) ? {{31{1'b0}}, (Sum[31])} :  // SLT (nếu A < B thì bit 31 = 1)
                    {32{1'b0}};                                   // Mặc định trả về 0

    // Tính cờ tràn (OverFlow)
    // Xảy ra khi cộng/trừ số có dấu dẫn đến sai dấu
    assign OverFlow = ((Sum[31] ^ A[31]) &                       // bit dấu kết quả khác bit dấu A
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &       // Xét loại phép (add/sub) và dấu B
                      (~ALUControl[1]));                         // Không áp dụng cho AND/OR/SLT

    // Cờ nhớ (Carry) chỉ áp dụng cho ADD/SUB (không áp dụng cho logic)
    assign Carry = ((~ALUControl[1]) & Cout);

    // Cờ Zero: bằng 1 nếu Result == 0
    assign Zero = &(~Result);

    // Cờ âm: bằng 1 nếu bit dấu của kết quả = 1
    assign Negative = Result[31];

endmodule
