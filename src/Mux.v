// module Mux (a,b,s,c);

//     input [31:0]a,b;
//     input s;
//     output [31:0]c;

//     assign c = (~s) ? a : b ;
    
// endmodule


module Mux (a, b, s, c);

    // Ngõ vào a và b là 2 giá trị 32-bit
    input [31:0] a, b;

    // Tín hiệu chọn: s = 0 → chọn a, s = 1 → chọn b
    input s;

    // Ngõ ra c là kết quả chọn giữa a hoặc b
    output [31:0] c;

    // Nếu s = 0 → c = a, ngược lại c = b
    assign c = (~s) ? a : b;
    
endmodule
