# • Si abbia un vettore contenente alcuni interi rappresentanti anni passati (0 ÷ 2018). Si scriva una procedura bisestile che sia in grado di determinare se tali anni 
# sono bisestili.
# • Si ricorda che un anno è bisestile se il suo numero è divisibile per 4, con l'eccezione che gli anni secolari (quelli divisibili per 100) sono bisestili solo se 
# divisibili anche per 400. 
# La procedura deve ricevere come input:
# – tramite il registro $a0, l‘indirizzo di un vettore di word contenente gli anni da valutare
# – tramite il registro $a1, l‘indirizzo di un vettore di byte della stessa lunghezza, che dovrà contenere, al termine dell'esecuzione della procedura, 
# nelle posizioni corrispondenti agli anni espressi nell'altro vettore, il valore 1 se l'anno è bisestile oppure 0 nel caso opposto
# – tramite il registro $a2, la lunghezza di tali vettori.

.data

DIM = 6

anni: .word 1945, 2008, 1800, 2006, 1748, 1600
risultato: .space DIM

.text
.globl main
.ent main

main:

    subu $sp, $sp, 4
    sw $ra, ($sp)

    la $a0, anni
    la $a1, risultato

    jal calcolaBisestile

    li $t0, 0
    la $a1, risultato

stampa_loop:

    lb $a0, ($a1)
    li $v0, 1
    syscall 

    addi $a1, $a1, 1
    addi $t0, $t0, 1

    blt $t0, DIM stampa_loop

    lw $ra, ($sp)
    addu $sp, $sp, 4

    jr $ra

.end main


.ent calcolaBisestile

calcolaBisestile:

    subu $sp, $sp, 16

    sw $s0, 12($sp)
    sw $s1, 8($sp)
    sw $s2, 4($sp)
    sw $s3, 0($sp)

    li $s0, 0 #contatore
    li $s1, 0 #Offset vettore anni/ anno corrente
    li $s2, 0 #Anno divisibile per 100/400 o per 4 
    li $s3, 0 #RestoDiv

loop:

    lw $s1, ($a0)

    li $s2, 100

    div $s1, $s2
    mfhi $s3

    bne $s3, 0, else

    li $s2, 400

    div $s1, $s2
    mfhi $s3

    beq $s3, 0, bisestile

    li $s3, 0
    j loop_continue

else:

    li $s2, 4 #Provo a dividere per 4

    div $s1, $s2
    mfhi $s3

    beq $s3, 0, bisestile
    
    li $s3, 0

    j loop_continue

bisestile:

    li $s3, 1

loop_continue:

    sb $s3, ($a1)
    addi $s0, $s0, 1

    addi $a1, 1
    addi $a0, 4

    blt $s0, DIM, loop

    lw $s3, 0($sp)
    lw $s2, 4($sp)
    lw $s1, 8($sp)
    lw $s0, 12($sp)

    addi $sp, $sp, 16

    jr $ra

.end calcolaBisestile
