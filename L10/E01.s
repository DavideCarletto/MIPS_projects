# Sono date due matrici quadrate contenenti numeri con segno, memorizzate per righe, di DIMxDIM elementi. Si scriva una procedura Variazione in linguaggio MIPS 
# in grado di calcolare la variazione percentuale (troncata all’intero) tra gli elementi di indice corrispondente della riga I della prima matrice ([I, 0], [I, 
# 1], [I, 2]…) e della colonna I della seconda ([0, I ], [1, I ], [2, I ]
# • La procedura riceve i seguenti parametri:
# – L’indirizzo della prima matrice mediante $a0
# – L’indirizzo della seconda matrice mediante $a1
# – L’indirizzo del vettore risultato mediante $a2
# – La dimensione DIM tramite $a3
# – L’indice I per mezzo dello stack.

DIM = 3
DIM_RIGA = DIM * 4
.data
mat1: .word 4, -45, 15565, 6458, 4531, 124, -548, 2124, 31000
mat2: .word 6, -5421, -547, -99, 4531, 1456, 4592, 118, 31999
indice: .word 2
vet_out: .space DIM_RIGA

.text
.globl main
.ent main
main:

    subu $sp, $sp, 4
    sw $ra, ($sp)

    la $a0, mat1
    la $a1, mat2
    la $a2, vet_out
    li $a3, DIM
    subu $sp, $sp, 4
    lw $t0, indice
    sw $t0, ($sp) 
    jal ProceduraVariazione
    
    lw $t0, ($sp)
    lw $ra, 4($sp)
    addu $sp, $sp, 8 
    
    jr $ra

.end main

.ent ProceduraVariazione

ProceduraVariazione:

    subu $sp, $sp, 12

    sw $s0, ($sp)
    sw $s1, 4($sp)
    sw $s2, 8 ($sp)

    li $s0, 0 # Contatore
    li $s1, 0 # Offset mat1
    li $s2, 0 # Offset mat2

    mult $a3, $t0
    mflo $s1
    sll $s1, $s1, 2
     

    sll $s2, $t0, 2

    add $a0, $a0, $s1
    add $a1, $a1, $s2

    loop_calcola:

    lw $s1, ($a0)
    lw $s2, ($a1)

    sub $s2, $s2, $s1
    mul $s2, $s2, 100
    mflo $s2
    div $s2, $s1
    mflo $s2

    sw $s2, ($a2)

    add $a0, $a0, 4 # Numero successivo stessa riga

    sll $s2, $a3, 2
    add $a1, $a1, $s2  # Calcolo numero successivo stessa colonna

    add $a2, $a2, 4

    addi $s0, $s0, 1
    bne $s0, $a3, loop_calcola     

    lw $s0, ($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)

    addu $sp, $sp, 12
    jr $ra

.end ProceduraVariazione
