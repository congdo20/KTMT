// module PC_Adder (a,b,c);

//     input [31:0]a,b;
//     output [31:0]c;

//     assign c = a + b;
    
// endmodule

module PC_Adder (a, b, c);

    // Ngõ vào a và b là 2 số 32-bit, thường là:
    // - a: giá trị hiện tại của PC
    // - b: offset (thường là 4 cho PC+4 hoặc immediate cho jump/branch)
    input [31:0] a, b;

    // Ngõ ra c là kết quả cộng a + b
    output [31:0] c;

    // Thực hiện phép cộng tổ hợp giữa a và b
    assign c = a + b;

endmodule
