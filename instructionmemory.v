//HECHO POR LUISA FERNANDA RAMIREZ Y BRAYAN CATAÑO GIRALDO
module instructionmemory(
    input [31:0] IMaddress,
    output reg [31:0] IMinstruction
    );
    reg [31:0] IMmemoria [0:1023];

    initial begin
        $readmemb("instrucciones.txt", IMmemoria);
    end

    always @(IMaddress) begin
        IMinstruction <= IMmemoria[{2'b00, IMaddress[31:2]}];
    end
endmodule