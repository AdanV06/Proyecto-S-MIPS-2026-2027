# Instrucciones: sw, lw.
# Comprueba que sw escribe y lw recupera datos usando offsets negativos.

        .data
slot_menos_8: .word 0
slot_menos_4: .word 0
base:         .word 0

        .text
main:
        la   $s0, base             # $s0 apunta a la tercera palabra

        lui  $t0, 0x1234
        ori  $t0, $t0, 0x5678     # $t0 = 0x12345678
        sw   $t0, -8($s0)         # escribe en slot_menos_8

        lui  $t1, 0x89ab
        ori  $t1, $t1, 0xcdef     # $t1 = 0x89abcdef
        sw   $t1, -4($s0)         # escribe en slot_menos_4

        lw   $a0, -8($s0)         # debe recuperar 0x12345678
        jal  imprimir_hex
        lw   $a0, -4($s0)         # debe recuperar 0x89abcdef
        jal  imprimir_hex
        jal  nueva_linea

        addi $v0, $zero, 10       # terminar
        syscall

# Imprime $a0 en hexadecimal (8 digitos) seguido de un espacio.
imprimir_hex:
        add  $t2, $a0, $zero
        addi $t3, $zero, 8
ih_bucle:
        srl  $t4, $t2, 28
        slti $t5, $t4, 10
        beq  $t5, $zero, ih_letra
        addi $a0, $t4, 48
        j    ih_imprime
ih_letra:
        addi $a0, $t4, 87
ih_imprime:
        addi $v0, $zero, 11
        syscall
        sll  $t2, $t2, 4
        addi $t3, $t3, -1
        bne  $t3, $zero, ih_bucle
        addi $a0, $zero, 32
        addi $v0, $zero, 11
        syscall
        jr   $ra

nueva_linea:
        addi $a0, $zero, 10
        addi $v0, $zero, 11
        syscall
        jr   $ra
