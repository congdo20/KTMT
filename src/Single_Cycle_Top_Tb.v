// module Single_Cycle_Top_Tb ();
    
//     reg clk=1'b1,rst;

//     Single_Cycle_Top Single_Cycle_Top(
//                                 .clk(clk),
//                                 .rst(rst)
//     );

//     initial begin
//         $dumpfile("Single Cycle.vcd");
//         $dumpvars(0);
//     end

//     always 
//     begin
//         clk = ~ clk;
//         #50;  
        
//     end
    
//     initial
//     begin
//         rst <= 1'b0;
//         #150;

//         rst <=1'b1;
//         #450;
//         $finish;
//     end
// endmodule


// Mô-đun Single_Cycle_Top_Tb
// Đây là mô phỏng (testbench) cho mô-đun Single_Cycle_Top, dùng để kiểm tra chức năng của hệ thống một chu kỳ (single cycle) trong một bộ xử lý.

module Single_Cycle_Top_Tb ();
    
    reg clk = 1'b1, rst; // Khai báo tín hiệu đầu vào: clk (tín hiệu đồng hồ) và rst (tín hiệu reset)

    // Khai báo mô-đun Single_Cycle_Top, kết nối với testbench này qua tín hiệu clk và rst
    Single_Cycle_Top Single_Cycle_Top (
                                .clk(clk),  // Kết nối tín hiệu đồng hồ
                                .rst(rst)   // Kết nối tín hiệu reset
    );

    // Khối initial để cấu hình và tạo file VCD (Value Change Dump) để theo dõi tín hiệu trong mô phỏng
    initial begin
        $dumpfile("Single_Cycle.vcd");  // Tạo file VCD với tên "Single_Cycle.vcd" để ghi lại các thay đổi tín hiệu
        $dumpvars(0);                    // Ghi lại toàn bộ tín hiệu trong mô phỏng
    end

    // Khối always tạo tín hiệu đồng hồ (clk) liên tục, thay đổi giá trị mỗi 50 đơn vị thời gian
    always 
    begin
        clk = ~clk;  // Đảo tín hiệu clk
        #50;         // Chờ 50 đơn vị thời gian trước khi thay đổi tín hiệu clk lần nữa
    end
    
    // Khối initial điều khiển tín hiệu reset (rst)
    initial
    begin
        rst <= 1'b0;    // Bắt đầu với tín hiệu reset = 0 (tắt reset)
        #150;           // Đợi 150 đơn vị thời gian trước khi thay đổi tín hiệu reset

        rst <= 1'b1;    // Kích hoạt tín hiệu reset = 1
        #450;           // Đợi 450 đơn vị thời gian trước khi kết thúc mô phỏng
        $finish;        // Kết thúc mô phỏng
    end
endmodule
