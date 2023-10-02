module imm (
  input [31:0] IMMins, 
  output reg [31:0] IMMout
);

always @(IMMins)
begin
    // Imm Tipo I
    if((IMMins[6:0] == 7'b0010011) || (IMMins[6:0] == 7'b0000011)) begin
        IMMout[11:0]  = IMMins[31:20];
        if((IMMins[4] == 1'b0) && (IMMins[14] == 1'b1)) begin
            IMMout[31:12] = 0;
        end
        else begin
            IMMout[31:12] = {20{IMMins[31]}};
        end
    end

    // Imm Tipo S
    else if (IMMins[6:0] == 7'b0100011) begin
        IMMout[4:0] = IMMins[11:7];
        IMMout[11:5] = IMMins[31:25];
        IMMout[31:12] = {20{IMMins[31]}};
    end

    // Imm Tipo B
    else if (IMMins[6:0] == 7'b1100011) begin
        IMMout[12] = IMMins[31];
        IMMout[10:5] = IMMins[30:25];
        IMMout[4:1] = IMMins[11:8];
        IMMout[11] = IMMins[7];
        IMMout[0] = 0;
        if((IMMins[14:12] == 3'b110) || (IMMins[14:12] == 3'b111)) begin
            IMMout[31:13] = 0;
        end
        else begin
            IMMout[31:13] = {19{IMMins[31]}};
        end
    end

    // Imm Tipo U
    else if ((IMMins[6:0] == 7'b0110111) || (IMMins[6:0] == 7'b0010111)) begin
        IMMout[31:12] = IMMins[31:12];
        IMMout[11:0] = 0;
    end

    // Imm Tipo J
    else if (IMMins[6:0] == 7'b1101111) begin
        IMMout[20] = IMMins[31];
        IMMout[10:1] = IMMins[30:21];
        IMMout[11] = IMMins[20];
        IMMout[19:12] = IMMins[19:12];
        IMMout[0] = 0;
        IMMout[31:21] = {11{IMMins[31]}};
    end

    // Default case
    else begin
        IMMout = 32'b0;
    end
end

endmodule
