//FUNCIONA
module pc (
    input wire clk,           // Señal de reloj
    input wire reset,         // Señal de reinicio
    input wire [31:0] PCdatain, // Entrada de datos
    output reg [31:0] PCout
);

always @(negedge clk) begin
    if (reset == 1) begin
        PCout <= 32'b00000000000000000000000000000000;
    end
    else begin
        PCout <= PCdatain;
    end
end

endmodule