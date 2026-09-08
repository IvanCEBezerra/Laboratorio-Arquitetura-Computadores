// multiplier_top.sv
// Modulo top-level da unidade de multiplicação de 32 bits
// Versão Refinada

module multiplier_top (
    input  logic        clk,
    input  logic        rst_n,
    input  logic        start,           // Inicia a multiplicacao
    input  logic [31:0] multiplicand_in, // Operando A (32 bits)
    input  logic [31:0] multiplier_in,   // Operando B (32 bits)
    output logic [63:0] product,         // Resultado A × B (64 bits)
    output logic        done             // Indica termino da operacao
);

    // -----------------------------------------------------------------------
    // Sinais internos entre controle e datapath
    // -----------------------------------------------------------------------
    logic load;
    logic product_wr;
    logic shift_en;
    logic product_lsb; // ALTERADO: Renomeado para refletir a nova origem do bit

    // -----------------------------------------------------------------------
    // Instancia do datapath
    // -----------------------------------------------------------------------
    multiplier_datapath datapath (
        .clk             (clk),
        .rst_n           (rst_n),
        .multiplicand_in (multiplicand_in),
        .multiplier_in   (multiplier_in),
        .load            (load),
        .product_wr      (product_wr),
        .shift_en        (shift_en),
        .multiplier_lsb  (product_lsb), // ALTERADO: Conectado ao novo fio
        .product         (product)
    );

    // -----------------------------------------------------------------------
    // Instancia da FSM de controle
    // -----------------------------------------------------------------------
    multiplier_control control (
        .clk             (clk),
        .rst_n           (rst_n),
        .start           (start),
        .done            (done),
        .product_lsb     (product_lsb), // ALTERADO: Conectado ao novo fio
        .load            (load),
        .product_wr      (product_wr),
        .shift_en        (shift_en)
    );

endmodule