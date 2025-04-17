// module Instruction_Memory(rst,A,RD);

//   input rst;
//   input [31:0]A;
//   output [31:0]RD;

//   reg [31:0] mem [1023:0];
  
//   assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

//   initial begin
//     $readmemh("memfile.hex",mem);
//   end


// /*
//   initial begin
//     //mem[0] = 32'hFFC4A303;
//     //mem[1] = 32'h00832383;
//     // mem[0] = 32'h0064A423;
//     // mem[1] = 32'h00B62423;
//     mem[0] = 32'h0062E233;
//     // mem[1] = 32'h00B62423;

//   end
// */
// endmodule


module Instruction_Memory(rst, A, RD);

  input rst;                // Tín hiệu reset
  input [31:0] A;           // Địa chỉ truy cập lệnh (thường từ PC)
  output [31:0] RD;         // Lệnh được đọc ra tại địa chỉ A

  // Bộ nhớ 4KB chứa các lệnh 32-bit
  reg [31:0] mem [1023:0];

  // Đọc lệnh từ bộ nhớ
  // Nếu đang reset (rst = 0) → trả về lệnh rỗng (32 bit 0)
  // Ngược lại, truy cập ô nhớ tại A[31:2] (bỏ 2 bit thấp để chia theo word)
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

  // Nạp chương trình từ file "memfile.hex" vào bộ nhớ khi bắt đầu mô phỏng
  initial begin
    $readmemh("memfile.hex", mem);
  end

  /*
  // Khối khởi tạo thủ công các lệnh (dùng khi không đọc từ file hex)
  initial begin
    //mem[0] = 32'hFFC4A303;     // lệnh giả sử
    //mem[1] = 32'h00832383;
    //mem[0] = 32'h0064A423;
    //mem[1] = 32'h00B62423;
    mem[0] = 32'h0062E233;       // ví dụ: lệnh thực hiện phép toán R-type
    //mem[1] = 32'h00B62423;
  end
  */

endmodule
