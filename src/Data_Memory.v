// module Data_Memory(clk,rst,WE,WD,A,RD);

//     input clk,rst,WE;
//     input [31:0]A,WD;
//     output [31:0]RD;

//     reg [31:0] mem [1023:0];

//     always @ (posedge clk)
//     begin
//         if(WE)
//             mem[A] <= WD;
//     end

//     assign RD = (~rst) ? 32'd0 : mem[A];

//     initial begin
//         mem[28] = 32'h00000020;
//         //mem[40] = 32'h00000002;
//     end


// endmodule


module Data_Memory(clk, rst, WE, WD, A, RD);

    // Định nghĩa các cổng I/O
    input clk, rst;            // xung nhịp và tín hiệu reset
    input WE;                  // Write Enable - cho phép ghi dữ liệu
    input [31:0] A, WD;        // A: địa chỉ; WD: dữ liệu ghi vào
    output [31:0] RD;          // RD: dữ liệu đọc ra

    // Định nghĩa vùng nhớ 1024 ô (4KB), mỗi ô 32-bit
    reg [31:0] mem [1023:0];

    // Khối xử lý ghi dữ liệu vào bộ nhớ
    always @ (posedge clk) begin
        if (WE) begin
            mem[A] <= WD;      // Nếu WE bật → ghi dữ liệu WD vào địa chỉ A
        end
    end

    // Đọc dữ liệu: nếu rst = 0 (đang reset), trả về 0;
    // ngược lại trả về dữ liệu tại địa chỉ A
    assign RD = (~rst) ? 32'd0 : mem[A];

    // Khởi tạo một số dữ liệu ban đầu trong bộ nhớ
    initial begin
        mem[28] = 32'h00000020;   // Khởi tạo ô nhớ thứ 28 chứa giá trị 32
        // mem[40] = 32'h00000002; // Dòng này đang bị comment
    end

endmodule
