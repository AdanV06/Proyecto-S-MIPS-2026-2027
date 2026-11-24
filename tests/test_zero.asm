# Test para el registro $zero
#Instrucciones: add, addi

.text
.globl main

main:
    addi $t0, $zero, 12
    addi $t1, $zero, 18

    # Intento de escritura: 12 + 18 = 30 en $zero.
    add $zero, $t0, $t1

    # Si $zero funciona correctamente, se imprime '0'.
    # Si la escritura anterior modifico $zero, saldra otro caracter.
    addi $a0, $zero, 48
    addi $v0, $zero, 11
    syscall

    # Finalizar.
    addi $v0, $zero, 10
    syscall
