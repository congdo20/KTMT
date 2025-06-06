`timescale 1ns / 1ps

module Sign_Extend_tb;

    reg [31:0] In;
    reg ImmSrc;
    wire [31:0] Imm_Ext;

    Sign_Extend uut (
        .In(In),
        .Imm_Ext(Imm_Ext),
        .ImmSrc(ImmSrc)
    );

    initial begin
        // Test case 1: I-type, positive immediate (ImmSrc = 0)
        In = 32'h000F_0000;  // In[31:20] = 0x000 -> expect 0x00000000
        ImmSrc = 0;
        #10;
        $display("Test 1 - I-type: In = 0x%h, Imm_Ext = 0x%h", In, Imm_Ext);

        // Test case 2: I-type, negative immediate (ImmSrc = 0)
        In = 32'hFFF0_0000;  // In[31:20] = 0xFFF -> expect 0xFFFFF000
        ImmSrc = 0;
        #10;
        $display("Test 2 - I-type (neg): In = 0x%h, Imm_Ext = 0x%h", In, Imm_Ext);

        // Test case 3: S-type, positive immediate (ImmSrc = 1)
        // In[31:25] = 0000000, In[11:7] = 00001 => Immediate = 0x0001
        In = 32'b0000000_00000_00000_000_00001_0100011;
        ImmSrc = 1;
        #10;
        $display("Test 3 - S-type: In = 0x%h, Imm_Ext = 0x%h", In, Imm_Ext);

        // Test case 4: S-type, negative immediate (ImmSrc = 1)
        // In[31:25] = 1111111, In[11:7] = 11111 => Immediate = 0xFFFFF
        In = 32'b1111111_00000_00000_000_11111_0100011;
        ImmSrc = 1;
        #10;
        $display("Test 4 - S-type (neg): In = 0x%h, Imm_Ext = 0x%h", In, Imm_Ext);

        $finish;
    end

endmodule

