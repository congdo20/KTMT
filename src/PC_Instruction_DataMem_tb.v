// `timescale 1ns/1ps

// module PC_Instruction_DataMem_tb;

//     reg clk = 0, rst;
//     wire [31:0] pc_out, instr, data_out;
//     wire [31:0] pc_next;

//     // Mô-đun PC
//     PC_Module pc (
//         .clk(clk),
//         .rst(rst),
//         .PC(pc_out),
//         .PC_Next(pc_next)
//     );

//     // PC cộng thêm 4
//     assign pc_next = pc_out + 4;

//     // Bộ nhớ lệnh
//     Instruction_Memory imem (
//         .rst(rst),
//         .A(pc_out),
//         .RD(instr)
//     );

//     // Bộ nhớ dữ liệu (đọc thử từ địa chỉ pc_out)
//     Data_Memory dmem (
//         .clk(clk),
//         .rst(rst),
//         .WE(0),          // Không ghi
//         .WD(32'b0),
//         .A(pc_out),
//         .RD(data_out)
//     );

//     // Tạo xung clock
//     always #5 clk = ~clk;

//     initial begin
//         rst = 0;
//         #10;
//         rst = 1;

//         // Chạy mô phỏng trong 5 chu kỳ
//         #50;
//         $finish;
//     end
// endmodule


`timescale 1ns / 1ps

module PC_Instruction_DataMem_tb;

    // ============================
    // Tín hiệu kết nối
    // ============================
    reg clk, rst;
    reg [31:0] PC_Next;        // Giá trị kế tiếp của PC
    wire [31:0] PC;            // Giá trị hiện tại của PC

    wire [31:0] Inst;          // Lệnh từ Instruction_Memory

    reg WE;                    // Write Enable cho Data_Memory
    reg [31:0] A, WD;          // Địa chỉ ghi và dữ liệu ghi
    wire [31:0] RD;            // Dữ liệu đọc từ Data_Memory

    // ============================
    // Khởi tạo mô-đun
    // ============================

    // PC
    PC_Module pc_inst (
        .clk(clk),
        .rst(rst),
        .PC_Next(PC_Next),
        .PC(PC)
    );

    // Instruction Memory (đọc theo PC)
    Instruction_Memory imem_inst (
        .rst(rst),
        .A(PC),
        .RD(Inst)
    );

    // Data Memory (đọc/ghi độc lập)
    Data_Memory dmem_inst (
        .clk(clk),
        .rst(rst),
        .WE(WE),
        .WD(WD),
        .A(A),
        .RD(RD)
    );

    // ============================
    // Clock tạo xung 10ns
    // ============================
    always #5 clk = ~clk;

    // ============================
    // Khối kiểm tra
    // ============================
    initial begin
        $display("=== Testbench PC + Instruction Memory + Data Memory ===");

        // Khởi tạo giá trị ban đầu
        clk = 0;
        rst = 0;
        WE = 0;
        PC_Next = 0;
        A = 0;
        WD = 0;

        // Reset hệ thống trong 10ns
        #10 rst = 1;

        // ============================
        // Test PC + Instruction Memory
        // ============================

        // PC = 0
        PC_Next = 32'h00000000;
        #10;

        // PC = 4
        PC_Next = 32'h00000004;
        #10;

        // PC = 8
        PC_Next = 32'h00000008;
        #10;

        // ============================
        // Test Data Memory Ghi và Đọc
        // ============================

        // Ghi vào địa chỉ 4 giá trị 0x12345678
        A = 32'h00000004;
        WD = 32'h12345678;
        WE = 1;
        #10;

        // Đọc lại địa chỉ 4
        WE = 0;
        A = 32'h00000004;
        #10;

        // Đọc địa chỉ đã khởi tạo ban đầu (28)
        A = 32'd28;
        #10;

        // Đọc địa chỉ chưa ghi (36)
        A = 32'd36;
        #10;

        $finish;
    end

    // ============================
    // Monitor in kết quả mô phỏng
    // ============================
    initial begin
        $monitor("Time=%0t | PC=%h | Inst=%h | A=%h | WD=%h | WE=%b | RD=%h",
                  $time, PC, Inst, A, WD, WE, RD);
    end

endmodule
