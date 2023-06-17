# La system call 1 scrive in output un numero intero con segno, compreso fra -2^31 e 2^31- 1.
# • Volendo stampare un intero unsigned su 32 bit, non è possibile utilizzare tale system call
# – Che valore è visualizzato se il numero è un intero senza segno compreso fra 2^32 e 2^32 – 1?
# • Data una variabile di tipo word in memoria inizializzata a 3141592653, si realizzi un programma che ne stampi il valore in output.
# • Il programma deve scrivere le singole cifre tramite la system call 11.

.data

ZERO= '0'

var: .word 3141592653

.text
.globl main
.ent main

main:

    li $t1, 10
    lw $t0, var
    li $t3, 0 # Contatore
 
loop:
    
    divu $t0, $t1
    mflo $t0
    mfhi $t2 # Resto della divisione

    subu $sp, $sp, 4
    sw $t2, 0($sp)

    addi $t3, $t3, 1
    bne $t0, 0, loop

stampa:

    lw $t2, 0($sp)
    addu $sp, $sp, 4
    addu $t2, $t2, ZERO

    addi $t3, $t3, -1

    move $a0, $t2
    li $v0, 11
    syscall
    bne $t3, 0, stampa

fine:

    li $v0, 10
    syscall

.end main
