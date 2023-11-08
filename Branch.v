module Branch(
    input  [4:0] BRopcode,
    input  [31:0] BRreg1,
    input  [31:0] BRreg2,
    output reg branch_next
);

    always @(*) begin 
        case (BRopcode)
        5'b00000: 
            if (BRreg1 == BRreg2) begin
                branch_next = 1;
            end
            /* else begin
                branch_next = 0;
            end */
        5'b00001: 
            if (BRreg1 != BRreg2) begin
                branch_next = 1;
            end
            /* else begin
                branch_next = 0;
            end */
        5'b00100:
            if (BRreg1 < BRreg2) begin
                branch_next = 1;
            end
            /* else begin
                branch_next = 0;
            end */
        5'b00101:
            if (BRreg1 >= BRreg2) begin
                branch_next = 1;
            end
            /* else begin
                branch_next = 0;
            end */
        5'b00110:
            if (BRreg1 < BRreg2) begin
                branch_next = 1;
            end
            /* else begin
                branch_next = 0;
            end */
        5'b00111:
            if (BRreg1 >= BRreg2) begin
                branch_next = 1;
            end
            /* else begin
                branch_next = 0;
            end */

        5'b11111:
            branch_next = 0;
            
        5'b01111:
            branch_next = 1;

        5'b10111:
            branch_next = 1;

        5'b10101:
            branch_next = 0;

        default:
            branch_next = 0;
        endcase
    end
endmodule
