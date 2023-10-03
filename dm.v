module DataMemory(
  input wire clk,          // Reloj
  input wire [31:0] DMAddress, // Dirección de memoria de 32 bits
  input wire [31:0] DMDataIn, // Datos de escritura de 32 bits
  input wire [2:0] DMCtrl, // Señal de control de la DM (000: Un byte (8 bits), 001: Dos bytes, media palabra (16 bits), 010: Cuatro bytes, palabra (32 bits), 100: Un byte unsigned (8 bits), 101: Dos bytes unsigned, media palabra (16 bits)
  input wire DMWrEnable,     // Señal de escritura habilitada
  output reg [31:0] DMDataOut // Datos leídos de 32 bits
);

  reg [7:0] DMmemory [0:4095]; // Memoria de datos de 8 bits y 4096 palabras

  initial begin
        $readmemb("dm.txt", DMmemory);
    end

  always @(posedge clk) begin //En flanco de subida se escribirá en la memoria
    if (DMWrEnable) begin // Si WrEnable está activado en flanco de bajada
      if (DMCtrl == 3'b000) begin
        DMmemory[DMAddress] <= DMDataIn[7:0]; // Almacena DataIn en la dirección especificada
      end
      else if (DMCtrl == 3'b001) begin
        DMmemory[DMAddress] <= DMDataIn[7:0]; // Almacena DataIn en la dirección especificada
        DMmemory[DMAddress+1] <= DMDataIn[15:8]; // Almacena DataIn en la dirección especificada + 1
      end
      else if (DMCtrl == 3'b010) begin
        DMmemory[DMAddress] <= DMDataIn[7:0]; // Almacena DataIn en la dirección especificada
        DMmemory[DMAddress+1] <= DMDataIn[15:8]; // Almacena DataIn en la dirección especificada + 1
        DMmemory[DMAddress+2] <= DMDataIn[23:16]; // Almacena DataIn en la dirección especificada + 2
        DMmemory[DMAddress+3] <= DMDataIn[31:24]; // Almacena DataIn en la dirección especificada + 3
      end
    end
  end

  always @(negedge clk) begin //En flanco de bajada se leerá de la memoria
    if (DMCtrl == 3'b000) begin
      DMDataOut <= {{24{DMmemory[DMAddress][7]}}, DMmemory[DMAddress]}; 
    end
    else if (DMCtrl == 3'b001) begin
      DMDataOut <= {{16{DMmemory[DMAddress+1][7]}}, DMmemory[DMAddress+1], DMmemory[DMAddress]};
    end
    else if (DMCtrl == 3'b010) begin
      DMDataOut <= {DMmemory[DMAddress+3], DMmemory[DMAddress+2], DMmemory[DMAddress+1], DMmemory[DMAddress]};
    end
    else if (DMCtrl == 3'b100) begin
    DMDataOut <= {{24{1'b0}}, DMmemory[DMAddress]};
  end
    else if (DMCtrl == 3'b101) begin
      DMDataOut <= {{16{1'b0}}, DMmemory[DMAddress+1], DMmemory[DMAddress]};
    end
  end

endmodule