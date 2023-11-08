//FUNCIONA
//HECHO POR LUISA FERNANDA RAMIREZ Y BRAYAN CATAÑO GIRALDO
module alu(
  input [31:0] ALUop1, // 32-bit value 1
  input [31:0] ALUop2, // 32-bit value 2
  input [2:0] ALUfunc3,    // Encodes part of the operation to be performed in 3 bits.
  input ALUsubsra,			// Encodes the distinction between operations in 1 bit.
  output reg [31:0] ALUresult // The result of the 32-bit operation 
);

  always @(ALUop1,ALUop2,ALUfunc3,ALUsubsra,ALUresult)
  begin
  case (ALUfunc3)
    3'b000: 
      if(!ALUsubsra)
        ALUresult = ALUop1 + ALUop2;		//Suma
      else 
      
      	ALUresult = ALUop1 - ALUop2;		//Resta
    3'b100: ALUresult = ALUop1 ^ ALUop2;	//XOR
    3'b110: ALUresult = ALUop1 | ALUop2;	//OR
    3'b111: ALUresult = ALUop1 & ALUop2;	//AND
    3'b101: ALUresult = ALUop1 >> ALUop2;	//Desplazamiento a la derecha
    3'b001: ALUresult = ALUop1 << ALUop2;	//Desplazamiento a la izquierda
    3'b010: ALUresult = ALUop1 < ALUop2;	//Menor qué
    3'b011: ALUresult = ALUop2;
  endcase
end
endmodule