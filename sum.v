module sum (
    input wire clk,          // Señal de reloj
    input wire reset,        // Señal de reinicio
    input wire [31:0] SUMdatain, // Entrada de datos desde el ProgramCounter
    output reg [31:0] SUMout // Salida de la suma
);

reg [31:0] constant_value = 32'b00000000000000000000000000000100; // Valor constante que deseas sumar

always @(negedge clk or negedge reset) begin
    if (reset) begin
        SUMout <= 32'b0; // Reinicia la salida en 0 cuando se active el reset
    end 
    else begin
        SUMout <= SUMdatain + constant_value; // Suma SUMdatain y el valor constante
    end
end

endmodule