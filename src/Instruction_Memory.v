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





// module Instruction_Memory(rst, A, RD);

//   input rst;                // Tín hiệu reset
//   input [31:0] A;           // Địa chỉ truy cập lệnh (thường từ PC)
//   output [31:0] RD;         // Lệnh được đọc ra tại địa chỉ A

//   // Bộ nhớ 4KB chứa các lệnh 32-bit
//   reg [31:0] mem [1023:0];

//   // Đọc lệnh từ bộ nhớ
//   // Nếu đang reset (rst = 0) → trả về lệnh rỗng (32 bit 0)
//   // Ngược lại, truy cập ô nhớ tại A[31:2] (bỏ 2 bit thấp để chia theo word)
//   assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

//   // Nạp chương trình từ file "memfile.hex" vào bộ nhớ khi bắt đầu mô phỏng
//   initial begin
//     $readmemh("memfile.hex", mem);
//   end




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

// endmodule



// module Instruction_Memory(rst, A, RD);

//   input rst;
//   input [31:0] A;
//   output [31:0] RD;

//   reg [31:0] mem [1023:0];

//   // Lệnh đọc từ bộ nhớ
//   assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

//   // Đọc từ file (nếu có)
//   initial begin
//     $readmemh("memfile.hex", mem);
//   end

//   // 👇 Thêm khối always để hiển thị lệnh đọc ra (mỗi khi địa chỉ A thay đổi)
//   always @(A) begin
//     if (rst)
//       $display(">>> [IMEM] At time %0t ns: PC = %08h, Instruction = %08h", $time, A, mem[A[31:2]]);
//   end

// endmodule


module Instruction_Memory(rst, A, RD);

  input rst;
  input [31:0] A;
  output [31:0] RD;

  reg [31:0] mem [1023:0];

  // Lệnh đọc từ bộ nhớ
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

  // Khởi tạo thủ công các lệnh và hiển thị mô tả
  initial begin
    // Ví dụ: Thủ công các lệnh minh họa
    // 0062E233 = ADDI x4, x0, 6      => x4 = 6
    // 00B67433 = ADD  x8, x12, x11   => x8 = x12 + x11
    // 00B60433 = ADD  x8, x12, x11   => giống dòng trên

    mem[0] = 32'h0062E233; // ADDI x4, x0, 6
    mem[1] = 32'h00B67433; // ADD  x14, x13, x6
    mem[2] = 32'h00B60433; // ADD  x8,  x12, x6
    mem[3] = 32'h41390433; // ADD  x9,  x18, x2
    mem[4] = 32'h015A4433; // ADD  x8,  x10, x5
    mem[5] = 32'h017B2433; // ADD  x8,  x15, x15
    mem[6] = 32'h0004A483; // LBU  x9,  4(x9)

    $display("\n=== [Instruction Memory Initialized] ===");
    $display("mem[0] = 0x%08h | ADDI x4, x0, 6       => x4 = 6",      mem[0]);
    $display("mem[1] = 0x%08h | ADD  x14, x13, x6    => x14 = x13 + x6", mem[1]);
    $display("mem[2] = 0x%08h | ADD  x8,  x12, x6    => x8 = x12 + x6",  mem[2]);
    $display("mem[3] = 0x%08h | ADD  x9,  x18, x2    => x9 = x18 + x2",  mem[3]);
    $display("mem[4] = 0x%08h | ADD  x8,  x10, x5    => x8 = x10 + x5",  mem[4]);
    $display("mem[5] = 0x%08h | ADD  x8,  x15, x15   => x8 = 2 * x15",    mem[5]);
    $display("mem[6] = 0x%08h | LBU  x12, 4(x5)      => x12 = Mem[x5 + 4] (1 byte, unsigned)", mem[6]);
    $display("=======================================\n");
  end

  // Khi địa chỉ thay đổi, hiển thị lệnh đang đọc và mô tả
  always @(A) begin
    if (rst) begin
      case (mem[A[31:2]])
       32'h0062E233: $display(">>> [IMEM] %0t ns | PC=%08h | 0062E233 | ADDI x4, x0, 6        => x4 = 6", $time, A);
        32'h00B67433: $display(">>> [IMEM] %0t ns | PC=%08h | 00B67433 | ADD x14, x13, x6      => x14 = x13 + x6", $time, A);
        32'h00B60433: $display(">>> [IMEM] %0t ns | PC=%08h | 00B60433 | ADD x8, x12, x6       => x8 = x12 + x6", $time, A);
        32'h41390433: $display(">>> [IMEM] %0t ns | PC=%08h | 41390433 | ADD x9, x18, x2       => x9 = x18 + x2", $time, A);
        32'h015A4433: $display(">>> [IMEM] %0t ns | PC=%08h | 015A4433 | ADD x8, x10, x5       => x8 = x10 + x5", $time, A);
        32'h017B2433: $display(">>> [IMEM] %0t ns | PC=%08h | 017B2433 | ADD x8, x15, x15      => x8 = 2 * x15", $time, A);
        32'h0004A483: $display(">>> [IMEM] %0t ns | PC=%08h | 0004A483 | LBU x12, 4(x5)        => x12 = Mem[x5 + 4] (1 byte, unsigned)", $time, A);
        default: $display(">>> [IMEM] %0t ns | PC=%08h | %08h | Unknown Instruction", $time, A, mem[A[31:2]]);
      endcase
    end
  end

endmodule
