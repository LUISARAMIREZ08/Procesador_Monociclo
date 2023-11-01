module Branch(
    input  [4:0] BRopcode,
    input  [31:0] BRregister1,
    input  [31:0] BRregister2,
    output reg branch_next
);

    always @(*) begin 
        case (BRopcode)
        5'b00000: 
            if (BRregister1 == BRregister2) begin
                branch_next = 1;
            end
        5'b00001: 
            if (BRregister1 != BRregister2) begin
                branch_next = 1;
            end
        5'b00100:
            if (BRregister1 < BRregister2) begin
                branch_next = 1;
            end
        5'b00101:
            if (BRregister1 >= BRregister2) begin
                branch_next = 1;
            end
        5'b00110:
            if (BRregister1 < BRregister2) begin
                branch_next = 1;
            end
        5'b00111:
            if (BRregister1 >= BRregister2) begin
                branch_next = 1;
            end
        5'b11111:
            branch_next = 0;
        default:
            branch_next = 0;
        endcase
    end
endmodule
