# Si scriva una procedura CalcolaDistanzaH in linguaggio assembly MIPS32 che  calcoli la distanza di Hamming binaria tra gli elementi di indice corrispondente di due vettori di word di lunghezza DIM (dichiarato come costante).

.data

DIM = 5
vet1: .word 56, 12, 98, 129, 58
vet2: .word 1, 0, 245, 129, 12
risultato: .space DIM
space: .asciiz ", "
message_out: .asciiz "Distanze di Hamming: "

.text
.globl main
.ent main

main:

    subu $sp, $sp, 4
    sw $ra, ($sp)

    la $a0, vet1
    la $a1, vet2
    la $a2, risultato
    li $a3, DIM
    
    jal CalcolaDistanzaH

    la $a1, risultato
    
    la $a0, message_out
    li $v0, 4
    syscall 

    stampa_loop:

    lw $a0, ($a1)
    li $v0, 1
    syscall 

    li $a0, 0
    li $v0, 0

    la $a0, space
    li $v0, 4
    syscall

    addi $a1, $a1, 4
    addi $t0, $t0, 1

    blt $t0, DIM stampa_loop

    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra
    
.end main

.ent CalcolaDistanzaH

CalcolaDistanzaH:

    # subu $sp, $sp, 20

    # sw $s0, 16($sp)
    # sw $s1, 12($sp)
    # sw $s2, 8($sp)
    # sw $s3, 4($sp)
    # sw $s4, ($sp)

    lw $s0, ($a0) # Numero 1
    lw $s1, ($a1) # Numero 2

    xor $s0, $s0, $s1 # Risultato xor

    li $s1, 0
    li $s2, 0 #Counter
    li $s3, 0 #Numero di bit a 1
    loop_count_bit:

    andi $s1, $s0, 1
    bne $s1, 1, right_shift 
    addi $s3, $s3, 1

    right_shift:

    srl $s0, $s0, 1

    addi $s2, $s2, 1
    bne $s2, 32, loop_count_bit

    sw $s3, ($a2)
    
    addi $a0, $a0, 4
    addi $a1, $a1, 4
    addi $a2, $a2, 4
    addi $s4, $s4, 1

    bne $s4, DIM, CalcolaDistanzaH


    # lw $s4, ($sp)
    # lw $s3, 4($sp)
    # lw $s2, 8($sp)
    # lw $s1, 12($sp)
    # lw $s0, 16($sp)

    # add $sp, $sp, 20

    jr $ra

.end CalcolaDistanzaH