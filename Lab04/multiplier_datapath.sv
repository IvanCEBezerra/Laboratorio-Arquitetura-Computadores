// multiplier_datapath.sv
// Datapath da unidade de multiplicacao (32 bits → produto de 64 bits)
// Versão Refinada (ALU 32-bits, Registrador de Produto de 65 bits)

module multiplier_datapath (
    input  logic        clk,
    input  logic        rst_n,
    // Entradas de dados
    input  logic [31:0] multiplicand_in,
    input  logic [31:0] multiplier_in,
    
    // Sinais de controle vindos da FSM
    input  logic        load,        // Carrega operandos iniciais
    input  logic        product_wr,  // Escreve soma da ALU em product_reg
    input  logic        shift_en,    // Shift right global
    
    // Saidas de status para a FSM
    output logic        multiplier_lsb, // Testa o LSB do multiplicador (agora dentro de product_reg)
    // Saída do resultado
    output logic [63:0] product
);

    // -----------------------------------------------------------------------
    // Registradores internos
    // -----------------------------------------------------------------------
    logic [31:0] multiplicand_reg; // ALTERADO: Reduzido para 32 bits, não precisa mais de 64
    // REMOVIDO: logic [31:0] multiplier_reg; (O multiplicador agora vive no Produto)
    logic [64:0] product_reg;      // ALTERADO: 65 bits para acomodar o carry-out

    // -----------------------------------------------------------------------
    // ALU (32-bit ALU)
    // -----------------------------------------------------------------------
    logic [32:0] alu_sum;          // ALTERADO: A soma de 32+32 gera 33 bits de saída
    
    alu_32 alu (                   // ALTERADO: O módulo alu_64 deve ser renomeado para alu_32
        .a   (product_reg[63:32]), // ALTERADO: Recebe apenas a metade superior do produto
        .b   (multiplicand_reg),
        .sum (alu_sum)
    );

    // -----------------------------------------------------------------------
    // Saídas combinacionais
    // -----------------------------------------------------------------------
    assign multiplier_lsb = product_reg[0]; // ALTERADO: O LSB agora é extraído do produto
    assign product        = product_reg[63:0]; // ALTERADO: A saída final corta o 65º bit

    // -----------------------------------------------------------------------
    // Atualizacao dos registradores
    // -----------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            multiplicand_reg <= '0;
            product_reg      <= '0;
        end else if (load) begin
            // Inicializacao da versão refinada:
            multiplicand_reg <= multiplicand_in;                   // ALTERADO: Recebe apenas 32 bits
            product_reg      <= {33'b0, multiplier_in};            // ALTERADO: 33 zeros na parte alta e multiplicador na baixa
        end else begin
            
            // Soma condicional
            if (product_wr)
                product_reg[64:32] <= alu_sum; // ALTERADO: Sobrescreve apenas a parte superior com o resultado e carry

            // Deslocamento
            if (shift_en) begin
                // REMOVIDO: shift left em multiplicand_reg
                // REMOVIDO: shift right em multiplier_reg
                product_reg <= {1'b0, product_reg[64:1]}; // ALTERADO: Desloca o registrador de 65 bits todo para a direita
            end
        end
    end

endmodule