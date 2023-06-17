# • Sia data una matrice quadrata di word memorizzata per righe (numero di righe pari a DIM, con DIM dichiarato come costante).
# • Si scriva un programma che sia in grado di valutare se la matrice quadrata è simmetrica o diagonale. Il programma dovrà stampare a video un valore pari a:
# – 2 se la matrice è diagonale
# – 1 se la matrice è simmetrica
# – 0 se la matrice non è simmetrica.

.data

DIM = 3
mat_diag: .word 3, 0, 0, 0, 1, 0, 0, 0, 2
mat_simm: .word 3, 2, 1, 2, 4, 0, 1, 0, 5
mat: .word 1, 2, 3, 4, 5, 6, 7, 8, 9
DIM_RIGA = DIM*4

.text
.globl main
.ent main

main:

    li $t0, 0 # Contatore riga
    li $t1, 0 # Contatore colonna
    li $t2, 0 #Offset Colonna
    li $t4, 0
    li $t5, 0 #Offset Riga
    li $t8, 0

check_diagonale_riga:

    li $t1, 0
    blt $t0, DIM, check_diagonale_colonna
    li $t4, 2
    j fine
    
check_diagonale_colonna:

    beq $t0, $t1, chiama_incrementa_colonna

    beq $t1, DIM, chiama_incrementa_riga
    lw $t3, mat_diag($t2)
    bne $t3, 0, check_simmetrica
    
    addi $t2, $t2, 4
    addi $t1, $t1, 1

    blt $t1, DIM, check_diagonale_colonna

    addi $t0, $t0, 1
    j check_diagonale_riga
    
chiama_incrementa_colonna:
    
    jal incrementa_colonna
    j check_diagonale_colonna

chiama_incrementa_riga:

    jal incrementa_riga
    j check_diagonale_riga

incrementa_colonna:
    addi $t1, $t1, 1
    addi $t2 $t2, 4
    jr $ra

incrementa_riga:

    addi $t0, $t0, 1
    addi $t5, $t5, DIM_RIGA
    jr $ra

check_simmetrica:
    move $t0, $t8
    move $t1, $t8
    li $t2, 0
    li $t5, 0
    
    blt $t8, DIM, check_simmetrica_ciclo
    li $t4, 1
    j fine

check_simmetrica_ciclo:

    lw $t6, mat_diag($t2)
    lw $t7, mat_diag($t5)

    bne $t6, $t7, no_simm
    jal incrementa_riga
    jal incrementa_colonna

    blt $t1, DIM, check_simmetrica_ciclo

    addi $t8, 1
    j check_simmetrica

no_simm:

    li $t4, 0
    j fine

fine:
    move $a0, $t4
    li $v0, 1
    syscall 

    li $v0, 10
    syscall
.end main
