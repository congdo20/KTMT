// // `include "PC.v"
// // `include "Instruction_Memory.v"
// // `include "Register_File.v"
// // `include "Sign_Extend.v"
// // `include "ALU.v"
// // `include "Control_Unit_Top.v"
// // `include "Data_Memory.v"
// // `include "PC_Adder.v"
// // `include "Mux.v"

// // module Single_Cycle_Top(clk,rst);

// //     input clk,rst;

// //     wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
// //     wire RegWrite,MemWrite,ALUSrc,ResultSrc;
// //     wire [1:0]ImmSrc;
// //     wire [2:0]ALUControl_Top;

// //     PC_Module PC(
// //         .clk(clk),
// //         .rst(rst),
// //         .PC(PC_Top),
// //         .PC_Next(PCPlus4)
// //     );

// //     PC_Adder PC_Adder(
// //                     .a(PC_Top),
// //                     .b(32'd4),
// //                     .c(PCPlus4)
// //     );
    
// //     Instruction_Memory Instruction_Memory(
// //                             .rst(rst),
// //                             .A(PC_Top),
// //                             .RD(RD_Instr)
// //     );

// //     Register_File Register_File(
// //                             .clk(clk),
// //                             .rst(rst),
// //                             .WE3(RegWrite),
// //                             .WD3(Result),
// //                             .A1(RD_Instr[19:15]),
// //                             .A2(RD_Instr[24:20]),
// //                             .A3(RD_Instr[11:7]),
// //                             .RD1(RD1_Top),
// //                             .RD2(RD2_Top)
// //     );

// //     Sign_Extend Sign_Extend(
// //                         .In(RD_Instr),
// //                         .ImmSrc(ImmSrc[0]),
// //                         .Imm_Ext(Imm_Ext_Top)
// //     );

// //     Mux Mux_Register_to_ALU(
// //                             .a(RD2_Top),
// //                             .b(Imm_Ext_Top),
// //                             .s(ALUSrc),
// //                             .c(SrcB)
// //     );

// //     ALU ALU(
// //             .A(RD1_Top),
// //             .B(SrcB),
// //             .Result(ALUResult),
// //             .ALUControl(ALUControl_Top),
// //             .OverFlow(),
// //             .Carry(),
// //             .Zero(),
// //             .Negative()
// //     );

// //     Control_Unit_Top Control_Unit_Top(
// //                             .Op(RD_Instr[6:0]),
// //                             .RegWrite(RegWrite),
// //                             .ImmSrc(ImmSrc),
// //                             .ALUSrc(ALUSrc),
// //                             .MemWrite(MemWrite),
// //                             .ResultSrc(ResultSrc),
// //                             .Branch(),
// //                             .funct3(RD_Instr[14:12]),
// //                             .funct7(RD_Instr[6:0]),
// //                             .ALUControl(ALUControl_Top)
// //     );

// //     Data_Memory Data_Memory(
// //                         .clk(clk),
// //                         .rst(rst),
// //                         .WE(MemWrite),
// //                         .WD(RD2_Top),
// //                         .A(ALUResult),
// //                         .RD(ReadData)
// //     );

// //     Mux Mux_DataMemory_to_Register(
// //                             .a(ALUResult),
// //                             .b(ReadData),
// //                             .s(ResultSrc),
// //                             .c(Result)
// //     );

// // endmodule


// // `include "PC.v"               // Mô-đun PC (Program Counter)
// // `include "Instruction_Memory.v" // Mô-đun bộ nhớ lệnh
// // `include "Register_File.v"     // Mô-đun thanh ghi
// // `include "Sign_Extend.v"       // Mô-đun mở rộng dấu
// // `include "ALU.v"               // Mô-đun ALU (Arithmetic Logic Unit)
// // `include "Control_Unit_Top.v"  // Mô-đun đơn vị điều khiển
// // `include "Data_Memory.v"       // Mô-đun bộ nhớ dữ liệu
// // `include "PC_Adder.v"          // Mô-đun cộng địa chỉ
// // `include "Mux.v"               // Mô-đun multiplexer (chọn tín hiệu)

// module RISCV_Single_Cycle(
//     input clk,  // Tín hiệu đồng hồ
//     input rst   // Tín hiệu reset
// );

//     // Khai báo các tín hiệu giữa các mô-đun
//     wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top, ALUResult, ReadData, PCPlus4, RD2_Top, SrcB, Result;
//     wire RegWrite, MemWrite, ALUSrc, ResultSrc;
//     wire [1:0] ImmSrc;
//     wire [2:0] ALUControl_Top;

//     // Mô-đun PC (Program Counter): Lưu trữ địa chỉ chương trình
//     PC_Module PC(
//         .clk(clk),
//         .rst(rst),
//         .PC(PC_Top),           // Địa chỉ chương trình hiện tại
//         .PC_Next(PCPlus4)      // Địa chỉ chương trình kế tiếp (PC + 4)
//     );

//     // Mô-đun PC Adder: Cộng địa chỉ PC hiện tại với 4 (địa chỉ của lệnh kế tiếp)
//     PC_Adder PC_Adder(
//         .a(PC_Top),        // Địa chỉ hiện tại của PC
//         .b(32'd4),         // Giá trị cộng vào là 4
//         .c(PCPlus4)        // Kết quả cộng (PC + 4)
//     );

//     // Mô-đun Instruction Memory: Lấy lệnh từ bộ nhớ theo địa chỉ của PC
//     Instruction_Memory Instruction_Memory(
//         .rst(rst),
//         .A(PC_Top),        // Địa chỉ lấy lệnh từ bộ nhớ
//         .RD(RD_Instr)      // Lệnh đọc được từ bộ nhớ
//     );

//     // Mô-đun Register File: Quản lý các thanh ghi trong bộ xử lý
//     Register_File Register_File(
//         .clk(clk),
//         .rst(rst),
//         .WE3(RegWrite),             // Tín hiệu cho phép ghi vào thanh ghi
//         .WD3(Result),               // Dữ liệu ghi vào thanh ghi
//         .A1(RD_Instr[19:15]),       // Địa chỉ thanh ghi nguồn 1
//         .A2(RD_Instr[24:20]),       // Địa chỉ thanh ghi nguồn 2
//         .A3(RD_Instr[11:7]),        // Địa chỉ thanh ghi đích
//         .RD1(RD1_Top),              // Dữ liệu đọc từ thanh ghi 1
//         .RD2(RD2_Top)               // Dữ liệu đọc từ thanh ghi 2
//     );

//     // Mô-đun Sign Extend: Mở rộng dấu dữ liệu lệnh (ví dụ: mở rộng từ 16 bit hoặc 12 bit)
//     Sign_Extend Sign_Extend(
//         .In(RD_Instr),              // Lệnh đầu vào
//         .ImmSrc(ImmSrc[0]),          // Tín hiệu chọn nguồn dữ liệu ngay lập tức
//         .Imm_Ext(Imm_Ext_Top)        // Dữ liệu mở rộng dấu
//     );

//     // Mô-đun Mux (Multiplexer): Lựa chọn giữa RD2_Top và Imm_Ext_Top tùy thuộc vào ALUSrc
//     Mux Mux_Register_to_ALU(
//         .a(RD2_Top),                // Thanh ghi thứ hai đọc được
//         .b(Imm_Ext_Top),            // Dữ liệu mở rộng dấu
//         .s(ALUSrc),                 // Tín hiệu chọn nguồn
//         .c(SrcB)                    // Kết quả ra (lựa chọn giữa RD2_Top và Imm_Ext_Top)
//     );

//     // Mô-đun ALU: Thực hiện phép toán giữa hai toán hạng
//     ALU ALU(
//         .A(RD1_Top),                // Toán hạng 1 (dữ liệu đọc từ thanh ghi 1)
//         .B(SrcB),                   // Toán hạng 2 (dữ liệu chọn từ Mux)
//         .Result(ALUResult),         // Kết quả phép toán ALU
//         .ALUControl(ALUControl_Top),// Điều khiển ALU (thực hiện phép toán nào)
//         .OverFlow(),                // Tín hiệu tràn
//         .Carry(),                   // Tín hiệu carry
//         .Zero(),                    // Tín hiệu zero (kết quả là 0)
//         .Negative()                 // Tín hiệu âm
//     );

//     // Mô-đun Control Unit: Quản lý tín hiệu điều khiển dựa trên opcode của lệnh
//     Control_Unit_Top Control_Unit_Top(
//         .Op(RD_Instr[6:0]),         // Opcode của lệnh
//         .RegWrite(RegWrite),         // Tín hiệu cho phép ghi vào thanh ghi
//         .ImmSrc(ImmSrc),             // Tín hiệu nguồn của dữ liệu ngay lập tức
//         .ALUSrc(ALUSrc),             // Tín hiệu chọn nguồn cho ALU
//         .MemWrite(MemWrite),         // Tín hiệu cho phép ghi vào bộ nhớ
//         .ResultSrc(ResultSrc),       // Tín hiệu chọn nguồn dữ liệu cho thanh ghi đích
//         .Branch(),                   // Tín hiệu điều kiện nhánh (không sử dụng trong ví dụ này)
//         .funct3(RD_Instr[14:12]),    // Ba bit của funct3 trong lệnh
//         .funct7(RD_Instr[6:0]),      // Bảy bit của funct7 trong lệnh
//         .ALUControl(ALUControl_Top)  // Điều khiển ALU
//     );

//     // Mô-đun Data Memory: Bộ nhớ dữ liệu (các giá trị cần ghi/đọc)
//     Data_Memory Data_Memory(
//         .clk(clk),                   // Tín hiệu đồng hồ
//         .rst(rst),                   // Tín hiệu reset
//         .WE(MemWrite),               // Tín hiệu ghi vào bộ nhớ
//         .WD(RD2_Top),                // Dữ liệu ghi vào bộ nhớ
//         .A(ALUResult),               // Địa chỉ bộ nhớ
//         .RD(ReadData)                // Dữ liệu đọc từ bộ nhớ
//     );

//     // Mô-đun Mux (Multiplexer): Lựa chọn giữa ALUResult và ReadData để ghi vào thanh ghi
//     Mux Mux_DataMemory_to_Register(
//         .a(ALUResult),              // Kết quả ALU
//         .b(ReadData),               // Dữ liệu đọc từ bộ nhớ
//         .s(ResultSrc),              // Tín hiệu chọn nguồn
//         .c(Result)                  // Dữ liệu kết quả cho thanh ghi
//     );

// endmodule



module RISCV_Single_Cycle(
    input clk,
    input rst_n
);

    wire rst = ~rst_n;

    wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top, ALUResult, ReadData, PCPlus4, RD2_Top, SrcB, Result;
    wire RegWrite, MemWrite, ALUSrc, ResultSrc;
    wire [1:0] ImmSrc;
    wire [2:0] ALUControl_Top;

    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)
    );

    Instruction_Memory IMEM_inst(  // Đặt đúng tên
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    Register_File Register_File(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .ImmSrc(ImmSrc[0]),
        .Imm_Ext(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
    );

    ALU ALU(
        .A(RD1_Top),
        .B(SrcB),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative()
    );

    Control_Unit_Top Control_Unit_Top(
        .Op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[6:0]),
        .ALUControl(ALUControl_Top)
    );

    Data_Memory DMEM_inst(  // Đặt đúng tên
        .clk(clk),
        .rst(rst),
        .WE(MemWrite),
        .WD(RD2_Top),
        .A(ALUResult),
        .RD(ReadData)
    );

    Mux Mux_DataMemory_to_Register(
        .a(ALUResult),
        .b(ReadData),
        .s(ResultSrc),
        .c(Result)
    );

    assign Instruction_out_top = RD_Instr;  // Xuất ra cho testbench

endmodule
