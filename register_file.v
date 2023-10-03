//HECHO POR LUISA FERNANDA RAMIREZ Y BRAYAN CATAÑO GIRALDO
module register_file(
  input [4:0] RFregister1,
  input [4:0] RFregister2,
  input [4:0] RFdestination_register,
  input [31:0] RFwrite_data,
  input RFwenable,
  input clk,
  output [31:0] RFdata1,
  output [31:0] RFdata2
);

  reg [31:0] RFregisters [31:0];
  reg [4:0] i;
  
  always @(negedge clk) begin
    if (RFwenable) begin
      if (RFdestination_register > 5'b00000) begin
      	RFregisters[RFdestination_register] <= RFwrite_data;
        // $display("Registro[%d] actualizado con valor %b", RFdestination_register, RFwrite_data);
      end
    end
  end

  // always @(*) begin
  //   for (i = 0; i < 32; i = i + 1) begin
  //     $display("Registro[%d] = %b", i, RFregisters[i]);
  //   end
  //   $display("/n /n /n");
  // end
  
  assign RFdata1 = RFregisters[RFregister1];
  assign RFdata2 = RFregisters[RFregister2];
  
endmodule
