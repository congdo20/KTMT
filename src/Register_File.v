// module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

//     input clk,rst,WE3;
//     input [4:0]A1,A2,A3;
//     input [31:0]WD3;
//     output [31:0]RD1,RD2;

//     reg [31:0] Register [31:0];

//     always @ (posedge clk)
//     begin
//         if(WE3)
//             Register[A3] <= WD3;
//     end

//     assign RD1 = (~rst) ? 32'd0 : Register[A1];
//     assign RD2 = (~rst) ? 32'd0 : Register[A2];

//     initial begin
//         Register[5] = 32'h00000005;
//         Register[6] = 32'h00000004;
        
//     end

// endmodule

// Mô-đun Register_File
// Mô phỏng một bộ nhớ thanh ghi với 32 thanh ghi, hỗ trợ đọc và ghi.

module Register_File(
    input clk,        // Tín hiệu đồng hồ (Clock)
    input rst,        // Tín hiệu reset
    input WE3,        // Tín hiệu "write enable" (cho phép ghi)
    input [4:0] A1,   // Địa chỉ thanh ghi 1 (5 bit)
    input [4:0] A2,   // Địa chỉ thanh ghi 2 (5 bit)
    input [4:0] A3,   // Địa chỉ thanh ghi 3 (5 bit), dùng cho việc ghi dữ liệu
    input [31:0] WD3, // Dữ liệu cần ghi vào thanh ghi chỉ định bởi A3
    output [31:0] RD1, // Dữ liệu đọc từ thanh ghi A1
    output [31:0] RD2  // Dữ liệu đọc từ thanh ghi A2
);

    // Khai báo mảng chứa 32 thanh ghi, mỗi thanh ghi 32 bit
    reg [31:0] Register [31:0];

    // Khối always thực hiện ghi dữ liệu vào thanh ghi tại địa chỉ A3 nếu WE3 được bật (1)
    always @ (posedge clk) begin
        if (WE3) begin
            // Ghi dữ liệu WD3 vào thanh ghi tại địa chỉ A3
            Register[A3] <= WD3;
        end
    end

    // Đọc dữ liệu từ thanh ghi A1 và A2
    // Nếu tín hiệu reset (rst) bằng 0, kết quả đọc sẽ là 0
    assign RD1 = (~rst) ? 32'd0 : Register[A1];
    assign RD2 = (~rst) ? 32'd0 : Register[A2];

    // Khối initial thiết lập giá trị ban đầu cho các thanh ghi (chỉ có giá trị mẫu cho thanh ghi 5 và 6)
    initial begin
        // Khởi tạo giá trị cho thanh ghi 5 và 6
        Register[5] = 32'h00000005; // Thanh ghi 5 có giá trị 0x00000005
        Register[6] = 32'h00000004; // Thanh ghi 6 có giá trị 0x00000004
    end

endmodule
