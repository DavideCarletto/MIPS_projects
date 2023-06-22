# • Sia data una matrice di byte, contenente numeri senza segno.
# • Si scriva una procedura contaVicini in grado di calcolare (e restituire come valore di ritorno) la somma dei valori contenuti nelle celle adiacenti ad una determinata cella.
# • La procedura contaVicini riceve i seguenti parametri:
#   – indirizzo della matrice
#   – numero progressivo della cella X, così come indicato nell’esempio a fianco
#   – numero di righe della matrice
#   – numero di colonne della matrice.
# • La procedura deve essere conforme allo standard per quanto riguarda passaggio di parametri, valore di ritorno e registri da preservare.

RIGHE = 4
COLONNE = 5 
.data
matrice: .byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62
.text
.globl main
.ent main

main:
    subu $sp, $sp, 4
    sw $ra, ($sp)

    la $a0, matrice
    li $a1, 12 #si parte da 0
    li $a2, RIGHE
    li $a3, COLONNE 

    jal contaVicini
    
    lw $ra, ($sp)
    addi $sp, $sp, 4

    jr $ra

.end main

.ent contaVicini

contaVicini:

    div $a1, $a3
    mflo $t0 #indice riga
    mfhi $t1 #indice colonna

    addi $t2, $t0, -1 #indice riga sopra
    bne $t2, -1, indiceRigaSotto
    move $t2, 0

    indiceRigaSotto:
        
        addi $t3, $t0, 1 #indice riga sotto
        bne $t3, $a2, indiceColonnaSinistra
        sub $t3, $a2, 1

    indiceColonnaSinistra:

        addi $t4, $t1, -1 #indice colonna sx
        bne $t4, -1 indiceColonnaDestra
        move $t4, $0

    indiceColonnaDestra: 

        addi $t5, $t1, 1 #indice colonna dx
        bne $t5, $a3, indiceCelle
        sub $t5, $a3, 1

    indiceCelle:

        mul $t1, $t2, $a3
        add $t0, $t1, $t4 #indice dell'elemento a sinistra della riga sopra
        add $t1, $t1, $t5 #indice dell'elemento a dx della riga sopra

        mul $t2, $t3, $a3
        add $t2, $t2, $t4 # indice dell'elemento a sinistra nella riga sotto
        add $t0, $t0, $a0 # somma l'indirizzo iniziale della matrice
        add $t1, $t1, $a0
        add $t2, $t2, $a0
        add $a1, $a1, $a0

    cicloEsterno: 

        move $t3, $t0 #t0 corrisponde all'indirizzo della matrice con colonna di partenza della riga da cui iniziare a contare

    cicloInterno: 

        beq $t3, $a1, saltaElemento #salto l'elemento solo se mi trovo sull'elemento centrale
        lb $t4, ($t3)
        add $v0, $v0, $t4

    saltaElemento: 

        add $t3, $t3, 1
        bleu $t3, $t1, cicloInterno #vado avanti finchè non ho raggiunto l'indice di dx della colonna corrente
        add $t0, $t0, $a3 #colonna di sx di una riga sotto
        add $t1, $t1, $a3 #colonna di dx di una riga sotto
        bleu $t0, $t2, cicloEsterno #riparto finché non ho finito le righe

    jr $ra

.end contaVicini