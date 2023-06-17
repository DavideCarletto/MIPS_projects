# • Si scriva una procedura massimo in grado di calcolare il valore massimo di un vettore di interi word.
# • La procedura riceve l’indirizzo del vettore in $a0 e la sua lunghezza in $a1, e salva il risultato in $v0.
# • Al termine della procedura, il main deve stampare a video il valore del massimo trovato.

.data

vett: .word 5, 4, -4, 2, 10, 5, 6
DIM = 7
message_out: .asciiz "Il massimo del vettore e' "

.text
.globl main
.ent main

main:

    la $a0, vett
    li $a1, DIM
    jal trova_max

    move $t0, $v0

    la $a0, message_out
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    j fine

trova_max:
    
    move $t0, $a0
    move $t1, $a1
    lw $v0, ($t0)

    ciclo:

        addi $t0, $t0, 4
        addi $t1, $t1, -1

        beq $t1, 0, fine_ciclo

        lw $t2, ($t0)
        
        bgt $v0, $t2, next

        move $v0, $t2
        j ciclo

next:
    j ciclo

fine_ciclo:

    jr $ra

fine:

    li $v0, 10
    syscall

.end main