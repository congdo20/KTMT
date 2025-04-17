// module PC_Module(clk,rst,PC,PC_Next);
//     input clk,rst;
//     input [31:0]PC_Next;
//     output [31:0]PC;
//     reg [31:0]PC;

//     always @(posedge clk)
//     begin
//         if(~rst)
//             PC <= {32{1'b0}};
//         else
//             PC <= PC_Next;
//     end
// endmodule

module PC_Module(clk, rst, PC, PC_Next);

    input clk, rst;               // clk: xung clock, rst: tín hiệu reset
    input [31:0] PC_Next;         // Giá trị PC tiếp theo (được tính từ PC+4 hoặc PC+offset)
    output [31:0] PC;             // Giá trị PC hiện tại
    reg [31:0] PC;                // Thanh ghi lưu giá trị PC

    // Khối always chạy khi có cạnh lên của clock
    always @(posedge clk)
    begin
        if (~rst)                 // Nếu rst = 0 → reset hệ thống
            PC <= {32{1'b0}};     // Đặt giá trị PC về 0
        else
            PC <= PC_Next;       // Nếu không thì cập nhật PC bằng giá trị mới (PC_Next)
    end

endmodule
