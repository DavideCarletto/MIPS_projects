# • La congettura di Collatz afferma che, per qualunque valore iniziale 𝑐0, la sequenza definita nell’esercizio precedente raggiunge sempre il valore 1 passando attraverso un numero finito di elementi.
# • Esempio: se 𝑐0= 19, la sequenza è: 19, 58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1. La sequenza contiene 21 elementi. 
# • La congettura di Collatz non è mai stata dimostrata, però è stata verificata sperimentalmente per tutti i numeri naturali fino a 87 * 260 ≈ 10^21.
# • Si scriva una procedura sequenzaDiCollatz che riceva tramite $a0 un numero naturale e restituisca attraverso $v0 il numero di elementi necessari per arrivare a 1.
# • La procedura è costituita da un ciclo che a ogni iterazione calcola l’elemento successivo della sequenza, richiamando la procedura calcolaSuccessivo implementata nell’esercizio precedente.
# • Nota: si ricordi di salvare il valore di $ra quando necessario

.data

message_in: .asciiz "Inserire il numero della successione:"
message_out: .asciiz "Numero di elementi necessari per arrivare a 1: "
new_line: .asciiz "\n"

.text
.globl main
.ent main

main:
    
    addi $sp, $sp, -4
    sw $ra, ($sp)

    la $a0, message_in
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $a0, $v0

    jal sequenzaDiCollatz
    
    lw $ra, ($sp)
    addi $sp, $sp, 4

    move $t0, $v0

    la $a0, message_out
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, new_line
    li $v0, 4
    syscall

    jr $ra

    .end main

.ent calcolaSuccessivo
calcolaSuccessivo:

    andi $t0, $a0, 1
    bnez $t0, dispari

    pari:
        
        sra $a0, $a0, 1
        move $v0, $a0
        jr $ra

    dispari:
        
        mul $a0, $a0, 3
        add $a0, $a0, 1
        move $v0, $a0
        jr $ra
    .end calcolaSuccessivo

.ent sequenzaDiCollatz
sequenzaDiCollatz: 

    addi $sp, $sp, -4
    sw $ra, ($sp)
    li $t1, 1

    loop:

    addi $t1, $t1, 1
    jal calcolaSuccessivo
    bne $v0, 1, loop

    move $v0, $t1

    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra
    .end sequenzaDiCollatz