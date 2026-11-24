# Instrucciones: jal, jr, addu, addiu, lw sw
#Prueba las llamadas anidadas y la preservacion de $ra meidante la pila

.text
.globl main

main:
    addiu $a0, $zero, 2       # Argumento inicial para proc_outer.
    jal   proc_outer         # Llamada 1: main -> proc_outer.

    # Al regresar, $v0 debe contener 7. Imprimir ese valor como un digito.
    addiu $a0, $v0, 48       # ASCII('0') + resultado.
    addiu $v0, $zero, 11
    syscall

    # Imprimir salto de linea.
    addiu $a0, $zero, 10
    addiu $v0, $zero, 11
    syscall

    # Finalizar el programa.
    addiu $v0, $zero, 10
    syscall

# Procedimiento no hoja: llama a proc_inner, por lo que debe preservar $ra.
proc_outer:
    addiu $sp, $sp, -4       # Reservar una palabra en la pila.
    sw    $ra, 0($sp)        # Guardar el retorno hacia main.

    addiu $a0, $a0, 1        # 2 + 1 = 3; argumento para proc_inner.
    jal   proc_inner         # Llamada 2: proc_outer -> proc_inner.

    addiu $v0, $v0, 1        # proc_inner devuelve 6; resultado final: 7.

    lw    $ra, 0($sp)        # Recuperar el retorno hacia main.
    addiu $sp, $sp, 4        # Liberar la palabra reservada.
    jr    $ra                # Retornar de proc_outer a main.

# Procedimiento hoja: devuelve el doble del argumento recibido.
proc_inner:
    addu  $v0, $a0, $a0      # 3 + 3 = 6.
    jr    $ra                # Retornar a la instruccion posterior a jal proc_inner.
