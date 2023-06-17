# Si scriva una procedura calcola_sconto in MIPS in grado di calcolare il prezzo scontato degli articoli venduti in un negozio e salvarlo nel corrispondente elemento del vettore scontati. La procedura riceve i 
# seguenti parametri:
# 1. indirizzo del vettore prezzi, contenente i prezzi di ciascun articolo venduto in un negozio
# 2. indirizzo del vettore scontati, inizialmente di contenuto indeterminato
# 3. numero di elementi contenuti nei due vettori
# 4. ammontare dello sconto percentuale da applicare
# 5. eventuale arrotondamento. Se il valore del parametro è 1, si deve eseguire un arrotondamento alla cifra superiore qualora la parte decimale del prezzo scontato sia maggiore o uguale a 0,5. Se il valore del parametro è 0, il prezzo 
# scontato è sempre arrotondato alla cifra inferiore.

.data

NUM = 5
DIM = NUM
SCONTO = 30
ARROTONDA = 1

prezzi: .word 39, 1880, 2394, 1000, 1590
scontati: .space DIM
space: .asciiz " "
.text
.globl main
.ent main

main:

    subu $sp, $sp, 8
    sw $ra, 4($sp)
    sw $t0 ($sp)

    la $a0, prezzi
    la $a1, scontati
    li $a2, NUM
    li $a3, SCONTO
    li $t0, ARROTONDA

    jal calcola_sconto

    li $t0, 0
    la $a1, scontati

    stampa_loop:

    lw $a0, ($a1)
    li $v0, 1
    syscall 

    la $a0, space
    li $v0, 4
    syscall

    addi $a1, $a1, 4
    addi $t0, $t0, 1

    blt $t0, DIM stampa_loop

    lw $t0, ($sp)
    lw $ra, 4($sp)
    addu $sp, $sp, 8

    jr $ra

.ent calcola_sconto

calcola_sconto:

    subu $sp, $sp, 20

    sw $s0, 16($sp) # Contatore
    sw $s1, 12($sp) # Offset
    sw $s2, 8($sp) # Valore prezzo/valore sconto
    sw $s3, 4($sp)
    sw $s4, ($sp) #Resto della divisione

    li $s0, 0
    li $s1, 0

    li $s4, 100
    subu $s3, $s4, $a3 #100-30 = 70

    loop:


    lw $s2, ($a0)

    li $s4, 100
    
    mult $s3, $s2 #prezzo *70
    mflo $s2

    div $s2, $s4 # Risultato / 100
    mfhi $s4 #Resto in s4
    mflo $s2 #Risultato in s2

    beq $t0, 0, store_scount
    blt $s4, 50, store_scount

    round_up:
    
    addi $s2, $s2, 1
    
    store_scount:

    sw $s2 ($a1)

    addi $s0, $s0, 1
    addi $a0, $a0, 4
    addi $a1, $a1, 4

    bne $s0, DIM, loop 

    lw $s4, ($sp)
    lw $s3, 4($sp)
    lw $s2, 8($sp)
    lw $s1, 12($sp)
    lw $s0, 16($sp) 

    addu $sp, $sp, 20

    jr $ra

.end calcola_sconto