// module Sign_Extend (In,Imm_Ext,ImmSrc);

//     input [31:0]In;
//     input ImmSrc;
//     output [31:0]Imm_Ext;

//     assign Imm_Ext = (ImmSrc == 1'b1) ? ({{20{In[31]}},In[31:25],In[11:7]}):
//                                         {{20{In[31]}},In[31:20]};
                                
// endmodule


// Mô-đun Sign_Extend
// Mô phỏng chức năng mở rộng dấu (Sign Extension) để chuyển đổi giá trị từ dạng 16 bit hoặc 12 bit thành 32 bit.

module Sign_Extend(
    input [31:0] In,    // Dữ liệu đầu vào 32 bit (In)
    input ImmSrc,       // Tín hiệu điều khiển để xác định kiểu mở rộng
    output [31:0] Imm_Ext // Kết quả mở rộng 32 bit
);

    // Quy trình mở rộng dấu (Sign Extension):
    // Nếu ImmSrc = 1 (chọn kiểu mở rộng cho định dạng I-type hoặc J-type):
    //  - Kết quả Imm_Ext sẽ được mở rộng từ 12 bit của In, với 20 bit dấu mở rộng từ bit 31 của In
    // Nếu ImmSrc = 0 (chọn kiểu mở rộng cho định dạng R-type):
    //  - Kết quả Imm_Ext sẽ được mở rộng từ 20 bit của In, với 12 bit dấu mở rộng từ bit 31 của In

    assign Imm_Ext = (ImmSrc == 1'b1) ? ({{20{In[31]}}, In[31:25], In[11:7]}) :
                                         {{20{In[31]}}, In[31:20]};

endmodule
