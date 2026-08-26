        addi x5, x0, 1          
        addi x6, x0, 17         
        sb   x5, 1029(x0)

espera_press:
        lb   x10, 1026(x0)
        andi x10, x10, 0x1
        beq  x10, x0, espera_press

espera_solta:
        lb   x10, 1026(x0)
        andi x10, x10, 0x1
        bne  x10, x0, espera_solta

        slli x5, x5, 1
        sb   x5, 1029(x0)
        beq  x5, x6, fim
        jal  x0, espera_press

fim:    jal  x0, fim

