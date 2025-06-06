`timescale 1ns / 1ps

module PC_Adder_tb;

    reg [31:0] a, b;
    wire [31:0] c;

    PC_Adder uut (
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        // Test case 1: 5 + 10 = 15
        a = 32'd5; b = 32'd10;
        #10;
        $display("Test 1: a=%d, b=%d, c=%d", a, b, c);

        // Test case 2: -5 + 10 = 5
        a = -32'd5; b = 32'd10;
        #10;
        $display("Test 2: a=%d, b=%d, c=%d", a, b, c);

        // Test case 3: -10 + (-20) = -30
        a = -32'd10; b = -32'd20;
        #10;
        $display("Test 3: a=%d, b=%d, c=%d", a, b, c);

        // Test case 4: INT_MAX + 1 = INT_MIN (overflow)
        a = 32'h7FFFFFFF; b = 32'd1;
        #10;
        $display("Test 4: a=%h, b=%h, c=%h", a, b, c);

        // Test case 5: 0 + 0 = 0
        a = 32'd0; b = 32'd0;
        #10;
        $display("Test 5: a=%d, b=%d, c=%d", a, b, c);

        $finish;
    end

endmodule

