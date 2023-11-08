`include "alu.v"
`include "dm.v"
`include "imm.v"
`include "instructionmemory.v"
`include "mux_alu_sum.v"
`include "mux_dm_alu_sum.v"
`include "mux_reg1_pc.v"
`include "mux_reg2_imm.v"
`include "pc.v"
`include "register_file.v"
`include "sum.v"
`include "Branch.v"

module cu(
    input wire clk,
    input wire reset
    
);

    wire [31:0] IMinstruction;
    reg [6:0] CUopcode;
    wire [31:0] ALUresult;
    wire [31:0] PCout;
    wire [31:0] SUMout;
    wire [31:0] MUX1out;
    wire [31:0] RFdata1;
    wire [31:0] RFdata2;
    wire [31:0] IMMout;
    wire [31:0] MUX2out;
    wire [31:0] MUX3out;
    wire [31:0] DMDataOut;
    wire [31:0] MUX4out;
    wire branch_next;

    reg [1:0] MUX4control;
    reg MUX2control;
    reg MUX3control;
    reg [4:0] CUrs1;
    reg [4:0] CUrs2;
    reg [4:0] CUrd;
    reg [2:0] CUfunc3;
    reg [4:0] BRopcode;
    reg CUrenable;
    reg CUdenable;
    reg CUsubsra;

    //Instanciación de los módulos

    //MUX alu and sum
    mux_alu_sum mux1(
        .MUX1alu(ALUresult), //Entrada del resultado de la ALU
        .MUX1sum(SUMout), //Entrada del contador de programa
        .MUX1control(branch_next), //Entrada de señal de control del mux 1 que indica si se debe saltar o no
        .MUX1out(MUX1out) //Salida del MUX 1
    );

    //Program Counter
    pc pc(
        .PCout(PCout), //Salida del contador de programa
        .PCdatain(MUX1out), //Entrada del número de instrucción
        .clk(clk), //Entrada de la señal de reloj
        .reset(reset) //Entrada de la señal de reinicio
    ); 

    //SUM
    sum sum(
        .SUMdatain(PCout), //Entrada del contador de programa
        .SUMout(SUMout) //Salida de la suma
    );

    //Instruction memory
    instructionmemory im(
        .IMaddress(PCout), //Entrada del contador de programa
        .IMinstruction(IMinstruction) //Salida de la instrucción
    );

    //Register file
    register_file rf(
        .RFr1(CUrs1), //Entrada del registro 1
        .RFr2(CUrs2), //Entrada del registro 2
        .RFrd(CUrd), //Entrada del registro de destino
        .RFwr(MUX4out), //Entrada de los datos a escribir del mux 4
        .RFwenable(CUrenable), //Entrada de la señal de escritura
        .clk(clk), //Entrada de la señal de reloj 
        .RFdata1(RFdata1), //Salida del dato 1
        .RFdata2(RFdata2) //Salida del dato 2
    );

    //Unidad de inmediatos
    imm imm(
        .IMMins(IMinstruction), //Entrada de la instrucción
        .IMMout(IMMout) //Salida del inmediato
    );

    //MUX pc and reg1
    mux_reg1_pc mux2(
        .MUX2pc(PCout), //Entrada del contador de programa
        .MUX2reg1(RFdata1), //Entrada del dato 1 del RegisterFile
        .MUX2control(MUX2control), //Entrada de la señal de control de la operación del MUX 2
        .MUX2out(MUX2out) //Salida del MUX 2
    );

    //MUX reg2 and imm
    mux_reg2_imm mux3(
        .MUX3reg2(RFdata2), //Entrada del dato 2 del RegisterFile
        .MUX3imm(IMMout), //Entrada del inmediato
        .MUX3control(MUX3control), //Entrada de la señal de control de la operación del MUX 3
        .MUX3out(MUX3out) //Salida del MUX 3
    );

    //BRANCH
    Branch branch(
        .BRreg1(RFdata1), //Entrada del dato 1 del RegisterFile
        .BRreg2(RFdata2), //Entrada del dato 2 del RegisterFile
        .BRopcode(BRopcode), //Entrada del opcode
        .branch_next(branch_next) //Salida de la señal de salto
    );  
    //ALU
    alu alu(
        .ALUop1(MUX2out), //Entrada del operando 1 del MUX 2
        .ALUop2(MUX3out), //Entrada del operando 2 del MUX 3
        .ALUfunc3(CUfunc3), //Entrada de la señal de control func3 de la operación de la ALU
        .ALUsubsra(CUsubsra), //Entrada de la señal de control func7 de la operación de la ALU
        .ALUresult(ALUresult) //Salida del resultado de la ALU
    );

    //Data memory
    DataMemory dm(
        .DMAddress(ALUresult), //Entrada de la dirección de memoria
        .DMDataIn(RFdata2), //Entrada de los datos a escribir
        .DMCtrl(CUfunc3), //Entrada de la señal de control de la DM
        .DMWrEnable(CUdenable), //Entrada de la señal de escritura habilitada
        .DMDataOut(DMDataOut) //Salida de los datos leídos de la DM
    );

    //MUX alu and dm and sum
    mux_dm_alu_sum mux4(
        .MUX4alu(ALUresult), //Entrada del resultado de la ALU
        .MUX4dm(DMDataOut), //Entrada de los datos leídos de la DM
        .MUX4sum(SUMout), //Entrada del contador de programa
        .MUX4control(MUX4control), //Entrada de la señal de control de la operación del MUX 4
        .MUX4out(MUX4out) //Salida del MUX 4
    );
    
    //Control unit
    always @(posedge clk) begin        // Cambiar a sensibilidad de flanco de subida
    CUopcode = IMinstruction[6:0];
    case(CUopcode)
        7'b0110011: begin          //INSTRUCCION TIPO R (OPCODE = 0110011)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = IMinstruction[24:20];
            CUrd = IMinstruction[11:7];
            CUfunc3 = IMinstruction[14:12];
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = IMinstruction[30];
            MUX2control = 1'b1;
            MUX3control = 1'b0;
            MUX4control = 2'b01;
            BRopcode = 5'b11111;
        end

        7'b0010011: begin          //INSTRUCCION TIPO I (OPCODE = 0010011)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = IMinstruction[14:12];
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b1;
            MUX3control = 1'b1;
            MUX4control = 2'b01;
            BRopcode = 5'b11111;
        end

        7'b0000011: begin          //INSTRUCCION TIPO I (OPCODE = 0000011)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = IMinstruction[14:12];
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b1;
            MUX3control = 1'b1;
            MUX4control = 2'b00;
            BRopcode = 5'b11111;
        end

        7'b0100011: begin       //INSTRUCCION TIPO S (OPCODE = 0100011)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = IMinstruction[24:20];
            CUrd = 5'b0;
            CUfunc3 = IMinstruction[14:12];
            CUrenable = 1'b0;
            CUdenable = 1'b1;
            CUsubsra = 1'b0;
            MUX2control = 1'b1;
            MUX3control = 1'b1;
            MUX4control = 2'b00;
            BRopcode = 5'b11111;
        end

        7'b1100011: begin       //INSTRUCCION TIPO SB (OPCODE = 1100011)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = IMinstruction[24:20];
            CUrd = 5'b0;
            CUfunc3 = IMinstruction[14:12];
            CUrenable = 1'b0;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b0;
            MUX3control = 1'b1;
            MUX4control = 2'b01;
            BRopcode = IMinstruction[14:12];
            // case (CUfunc3)
            //     3'b000: begin
            //         BRopcode = 5'b00000;
            //     end
            //     3'b001: begin
            //         BRopcode = 5'b00001;
            //     end
            //     3'b100: begin
            //         BRopcode = 5'b00100;
            //     end
            //     3'b101: begin
            //         BRopcode = 5'b00101;
            //     end
            //     3'b110: begin
            //         BRopcode = 5'b00110;
            //     end
            //     3'b111: begin
            //         BRopcode = 5'b00111;
            //     end
            // endcase
        end
        7'b1100111: begin       //INSTRUCCION TIPO JALR (OPCODE = 1100111)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = 3'b0;    
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b1;
            MUX3control = 1'b1;
            MUX4control = 2'b10;
            BRopcode = 5'b01111;
        end
        7'b1101111: begin       //INSTRUCCION TIPO JAL(OPCODE = 1101111)
            CUrs1 = 5'b0;
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = 3'b0;    
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b0;
            MUX3control = 1'b1;
            MUX4control = 2'b10;
            BRopcode = 5'b01111;
        end
        7'b0110111: begin       //INSTRUCCION TIPO U LUI (OPCODE = 0110111)
            CUrs1 = 5'b0;
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = 3'b0;    
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b0;
            MUX3control = 1'b1;
            MUX4control = 2'b01;
            BRopcode = 5'b11111;
        end
        7'b0010111: begin       //INSTRUCCION TIPO U AUIPC (OPCODE = 0010111)
            CUrs1 = 5'b0;
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = 3'b0;    
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b0;
            MUX3control = 1'b1;
            MUX4control = 2'b01;
            BRopcode = 5'b11111;
        end

        7'b1100111: begin      //INSTRUCCION TIPO I (OPCODE = 1100111)
            CUrs1 = IMinstruction[19:15];
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = IMinstruction[14:12];
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b1;
            MUX3control = 1'b1;
            MUX4control = 2'b10;
            BRopcode = 5'b01111;
        end

        7'b1101111: begin      //INSTRUCCION TIPO J (OPCODE = 1101111)
            CUrs1 = 5'b0;
            CUrs2 = 5'b0;
            CUrd = IMinstruction[11:7];
            CUfunc3 = 3'b0;
            CUrenable = 1'b1;
            CUdenable = 1'b0;
            CUsubsra = 1'b0;
            MUX2control = 1'b0;
            MUX3control = 1'b1;
            MUX4control = 2'b10;
            BRopcode = 5'b01111;
        end

        7'b0000000: begin
            CUrenable = 1'b0;
            CUdenable = 1'b0;
        end
    endcase 
end

endmodule