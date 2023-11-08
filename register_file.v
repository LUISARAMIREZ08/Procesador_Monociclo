//HECHO POR LUISA FERNANDA RAMIREZ Y BRAYAN CATAÑO GIRALDO
module register_file(
  input [4:0] RFr1,
  input [4:0] RFr2,
  input [4:0] RFrd,
  input [31:0] RFwr,
  input RFwenable,
  input clk,
  output [31:0] RFdata1,
  output [31:0] RFdata2
);

  reg [31:0] RFregisters [31:0];
  integer i;
  
  initial begin
    $readmemb("registers.txt", RFregisters);
  end

  always @(negedge clk) begin
    if (RFwenable) begin
      if (RFrd > 5'b00000) begin
      	RFregisters[RFrd] <= RFwr;
        $display("------------------------------------------------------------------");
        // $display("Registro[%d] actualizado con valor %d", RFrd, RFwr);
        for (i = 0; i < 32; i = i + 1) begin
          $display("R[%d] = %d", i, RFregisters[i]);
        end
        $display("------------------------------------------------------------------");
      end
    end
  end

  // always @(posedge clk) begin
  //   for (i = 0; i < 32; i = i + 1) begin
  //     $display("R[%d] = %d", i, RFregisters[i]);
  //   end
  //   $display("----------------------------------------");
  // end
  
  assign RFdata1 = RFregisters[RFr1];
  assign RFdata2 = RFregisters[RFr2];
  
endmodule