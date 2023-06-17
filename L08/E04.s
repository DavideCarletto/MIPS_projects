# Si scriva una procedura determinante2x2 che calcoli il valore del determinante di una matrice quadrata 2x2, ricevendo i 4 elementi tramite i registri $a0, $a1, $a2 e $a3 (matrice memorizzata per righe) e salvi il risultato in $v0
# 𝑑𝑒𝑡 =
# 𝑎1 𝑏1
# 𝑎2 𝑏2
# = 𝑎1𝑏2 − 𝑎2𝑏1
# • Per validare la procedura, si scriva anche un programma chiamante che legga 4 valori salvati in memoria e lanci la procedura. Si termini il programma chiamante con jr $ra.
# • Si assuma di non avere overflow nei calcoli.

.data

a1: .word  2
a2: .word 5
b1: .word 6
b2: .word 2

message_out: .asciiz "Il determinante della matice e':"

.text
.globl main
.ent main


main:

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    lw $a0, a1
    lw $a1, b1
    lw $a2, a2
    lw $a3, b2

    jal determinante2x2

    move $t0, $v0

    la $a0, message_out
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    jr $ra

.end main

.ent determinante2x2
determinante2x2:

    addi $sp, $sp, -16

    sw $a3, 12($sp)
    sw $a2, 8($sp)
    sw $a1, 4($sp)
    sw $a0, 0($sp)


    mult $a0, $a3
    mflo $a0

    mult $a1, $a2
    mflo $a1

    sub $a0, $a0, $a1

    move $v0, $a0

    lw $a0, 0($sp)
    lw $a1, 4($sp)
    lw $a2, 8($sp)
    lw $a3, 12($sp)

    addi $sp, $sp, 16

    jr $ra
.end determinante2x2