# • Si scriva una procedura determinante3x3 in grado di calcolare il determinante di una matrice quadrata 3x3.
# • La procedura determinante3x3 riceve in input i 9 elementi della matrice. I primi 4 elementi sono passati attraverso i registri $a0-$a3, gli altri 5 attraverso lo stack.
# • La procedura determinante3x3 chiama 3 volte la procedura determinante2x2 implementata nell’esercizio 4.
# • Per validare la procedura, si scriva un anche un programma chiamante che legga 9 valori salvati in memoria e lanci la procedura. Si termini il programma chiamante con jr $ra.
# • Si assuma di non avere overflow nei calcoli.

.data

matrice: .word 1, 41, 42, 13, 56, 23, 73, 9, 50
msg_output: .asciiz "Valore determinante: "

.text
.globl main
.ent main 
main:

    subu $sp, $sp, 4 # salvataggio di $ra nello stack
    sw $ra, ($sp)

    la $t0, matrice
    lw $a0, ($t0)
    lw $a1, 4($t0)
    lw $a2, 8($t0)
    lw $a3, 12($t0)

    move $t1, $0 # indice del ciclo

ciclo: #Salvo gli altri 5 parametri nello stack
    lw $t2, 16($t0) 
    addi $sp, $sp, -4
    sw $t2, ($sp)

    addi $t1, $t1, 1
    addi $t0, $t0, 4

    bne $t1, 5 ciclo

    jal determinante3x3

    la $a0, msg_output # argomento: stringa
    li $v0, 4 # syscall 4 (print_str)
    syscall
    move $a0, $t0 # intero da stampare
    li $v0, 1
    syscall
    lw $ra, 20($sp)
    addu $sp, 24
    jr $ra
.end main

determinante3x3: 
    
    subu $fp, $sp, 4
    subu $sp, 20 # salva ra e s0-s3

    sw $s0, ($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra, 16($sp)

    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3
    
    lw $a0, 20($fp) # b2
    lw $a1, 16($fp) # c2
    lw $a2, 8($fp) # b3
    lw $a3, 4($fp) # c3

    # a1 x (b2xc3 – b3xc2)
    # A0 x (A4xA8 – A7xA5)
    # (b2, c2, b3, c3)
    
    jal determinante2x2
    mul $s0, $s0, $v0
    move $a0, $s3
    lw $a1, 16($fp)
    lw $a2, 12($fp)
    lw $a3, 4($fp)
    
    # (a2, c2, a3, c3)
    jal determinante2x2
    mul $s1, $s1, $v0
    move $a0, $s3
    lw $a1, 20($fp)
    lw $a2, 12($fp)
    lw $a3, 8($fp)
    
    # (a2, b2, a3, b3)
    jal determinante2x2
    mul $s2, $s2, $v0
    add $v0, $s0, $s2
    sub $v0, $v0, $s1

    lw $s0, ($sp) # rispristina ra e s0-s3
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addu $sp, 20
    jr $ra
.end determinante3x3

.ent determinante2x2
determinante2x2:
    mul $t0, $a0, $a3
    mul $t1, $a1, $a2
    sub $v0, $t0, $t1
    jr $ra
.end determinante2x2
