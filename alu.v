//FUNCIONA
//HECHO POR LUISA FERNANDA RAMIREZ Y BRAYAN CATAÑO GIRALDO
module alu(
  input [31:0] ALUoperand1, // 32-bit value 1
  input [31:0] ALUoperand2, // 32-bit value 2
  input [2:0] ALUfunc3,    // Encodes part of the operation to be performed in 3 bits.
  input ALUsubsra,			// Encodes the distinction between operations in 1 bit.
  output reg [31:0] ALUresult // The result of the 32-bit operation 
);

  always @(ALUoperand1,ALUoperand2,ALUfunc3,ALUsubsra,ALUresult)
  begin
  case (ALUfunc3)
    3'b000: 
      if(!ALUsubsra)
        ALUresult = ALUoperand1 + ALUoperand2;		//Suma
      else 
      
      	ALUresult = ALUoperand1 - ALUoperand2;		//Resta
    3'b100: ALUresult = ALUoperand1 ^ ALUoperand2;	//XOR
    3'b110: ALUresult = ALUoperand1 | ALUoperand2;	//OR
    3'b111: ALUresult = ALUoperand1 & ALUoperand2;	//AND
    3'b101: ALUresult = ALUoperand1 >> ALUoperand2;	//Desplazamiento a la derecha
    3'b001: ALUresult = ALUoperand1 << ALUoperand2;	//Desplazamiento a la izquierda
    3'b010: ALUresult = ALUoperand1 < ALUoperand2;	//Menor qué
    3'b011: ALUresult = ALUoperand2;
  endcase
end
endmodule