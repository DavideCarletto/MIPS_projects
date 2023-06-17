# • Si scriva una procedura polinomio in grado di calcolare il valore di un polinomio p(x) di terzo grado senza usare moltiplicazioni, tramite il metodo delle differenze finite.
# • Nel main, inizializzare i registri $t0, $t1, $t2 e $t3 con i coefficienti del polinomio.
# Esempio: p(x) = 4x^3 + 2x^2 – 5x + 3
# $t0 = 4, $t1 = 2, $t2 = -5, $t3 = 3 
# • Nel main, inizializzare alcuni registri con valori utili: 
# $s0 = 2^3 :($t1)= 8; $s1 = 2^2:($t1)= 4; $s2 = 3^3:($t3)= 27; $s3 = 3^2:($t3)= 9; $s4 = 4^3:($t0)= 64; $s5 = 4^2:($t0)= 16
# • Il main richiama la procedura polinomio passando come argomenti p(1), p(2), p(3), p(4) e il valore N, per ottenere p(N).

.data
    N = 7

    c0: .word 4
    c1: .word 2
    c2: .word -5
    c3: .word 3

.text
.globl main
.ent main


main:
    addi $sp, $sp, 4 #Mi salvo l'indrizzo di ritorno
    sw $ra, ($sp)

    lw $t0, c0
    lw $t1, c1
    lw $t2, c2
    lw $t3, c3

    mul $s0, $t1, $t1
    mul $s0, $s0, $t1
    mul $s1, $t1, $t1 
    mul $s2, $t3, $t3
    mul $s2, $s2, $t3
    mul $s3, $t3, $t3
    mul $s4, $t0, $t0
    mul $s4, $s4, $t0
    mul $s5, $t0, $t0

    # Calcolo $a0
    add $a0, $t0, $t1
    add $a0, $a0, $t2
    add $a0, $a0, $t3
    # Calcolo $a1
    mul $a1, $t0, $s0
    mul $t8, $t1, $s1
    add $a1, $a1, $t8
    mul $t8, $t2, 2
    add $a1, $a1, $t8
    add $a1, $a1, $t3

    # Calcolo $a2
    mul $a2, $t0, $s2
    mul $t8, $t1, $s3
    add $a2, $a2, $t8
    mul $t8, $t2, 3
    add $a2, $a2, $t8
    add $a2, $a2, $t3
    # Calcolo $a3
    mul $a3, $t0, $s4
    mul $t8, $t1, $s5
    add $a3, $a3, $t8
    mul $t8, $t2, 4
    add $a3, $a3, $t8
    add $a3, $a3, $t3

    addi $sp, $sp, -16
    sw $t0, 12($sp)
    sw $t1, 8($sp)
    sw $t2, 4($sp)
    sw $t3, 0($sp)

    li $t8, N
    addi $sp, $sp, -4
    sw $t8, 0($sp)

    jal polinomio

    #pop parametro (a vuoto)
    addi $sp, $sp, 4
    #ripristino registri $tx
    lw $t3, 0($sp)
    lw $t2, 4($sp)
    lw $t1, 8($sp)
    lw $t0, 12($sp)
    addiu $sp, $sp, 16

    #ripristino indirizzo ritorno
    lw $ra, ($sp)
    addiu $sp, $sp, 4
    jr $ra

.end main

polinomio: 

    subu $fp, $sp, 4 # usare $fp permette di avere un riferimento
    # costante ai parametri ricevuti dal main
    #salvataggio registri $sx
    subu $sp, $sp, 12
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)

    sub $t0, $a1, $a0
    sub $t1, $a2, $a1
    sub $t2, $a3, $a2
    sub $s0, $t1, $t0
    sub $s1, $t2, $t1
    sub $s2, $s1, $s0
    move $v0, $a3

    # prelevamento dati da stack
    lw $t8, 4($fp) # Valore N
    addi $t8, -4

    ciclo: 

        add $s1, $s1, $s2
        add $t2, $t2, $s1
        add $v0, $v0, $t2
        addi $t8, -1
        bnez $t8, ciclo
        # ripristino registri $sx
        lw $s2, 0($sp)
        lw $s1, 4($sp)
        lw $s0, 8($sp)
        addiu $sp, $sp, 12
        jr $ra

.end polinomio



