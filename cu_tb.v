`include "cu.v"

module cu_tb;

  // Definición de señales de entrada/salida
  reg clk;
  reg reset;
  // Define otras señales de entrada aquí según tus necesidades
  
  // Instancia el módulo bajo prueba
  cu cu_inst (
    .clk(clk),
    .reset(reset)
    // Conecta otras señales de entrada/salida aquí
  );

  // Genera señal de reloj
  always begin
    #5 clk = ~clk; // Invierte la señal de reloj cada 5 unidades de tiempo
  end

  // Inicialización
  initial begin
    $dumpfile("cu_tb.vcd"); // Genera archivo VCD para visualizar la simulación
    $dumpvars; // Genera archivo VCD para visualizar la simulación
    clk = 0;
    reset = 0;
    
    // Aplica un reset inicial (puedes ajustar según sea necesario)
    reset = 1;
    #10 reset = 0;
    
    // Aplica patrones de entrada aquí (por ejemplo, cambios en las señales de control)
    
    // Simula durante un período de tiempo
    #160; // Ajusta según la duración de la simulación que deseas
    $finish; // Finaliza la simulación
  end



endmodule
