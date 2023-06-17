# • Implementare in Assembly MIPS il programma che scriva la somma di ciascuna riga e colonna rispettivamente nell’ultima colonna e riga.

.data

NUMRIG = 4
NUMCOL = 6

DIMRIG = NUMCOL*4

mat: .word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
.ent main

main:
	la $t0, mat 	# Offset
	li $t1, 0 		# Contatore righe
	li $t3, 0		# Accumulatore

Ciclo1:

	li $t4, 0
	li $t2, 1		# Contatore colonne
	
	addi $t1, $t1, 1

	
Cicloriga1:
	
	lw $t3, ($t0)	# Prendo l'elemento della matrice all'indirizzo contenuto in t0
	add $t4, $t3, $t4	# Incremento l'accumulatore per il risultato finale
	
	addi $t0, $t0, 4	# Accedo all'elemento successivo (nella stessa riga)
	addi $t2, $t2, 1	# Incremento accumulatore
	
	blt $t2, NUMCOL, Cicloriga1	# Controllo di non essere ancora arrivato alla posizione NUMCOL
	
	sw $t4, ($t0)	# Arrivato all'ultimo elemento della riga inserisco il valore contenuto in t4)
	addi $t0, $t0, 4	# Vado alla colonna successiva (che sarà la prima colonna della riga successiva dato che la matrice è sequenziale)
	
	blt $t1, NUMRIG, Ciclo1	# Ripeto il ciclo su tutte le righe
	
	li $t1, 1
	li $t2, 0
	

Ciclo2:
	
	la $t0, mat	#Carico l'indirizzo di partenza di mat
	sll $t3, $t2, 2	# Utilizzo il contatore per capire quanto sommare all'indirizzo di mat per posizionarmi sulla colonna corrente
	add $t0, $t0, $t3	# Mi posiziono sulla colonna corrente
	
	li $t1, 1
	li $t3, 0
	li $t4, 0
	
	addi $t2, $t2, 1


CicloColonna2:

	lw $t3, ($t0)
	add $t4, $t3, $t4	
	
	addi $t0, $t0, DIMRIG	# Per accedere alla stessa colonna della riga successiva incremento l'idirizzo di NUMCOL*4
	addi $t1, $t1, 1		# Incremento contatore
	
	blt $t1, NUMRIG, CicloColonna2
	
	sw $t4, ($t0)
	addi $t0, $t0, DIMRIG
	
	blt $t2, NUMCOL, Ciclo2
	
fine:

	li $v0, 10
	syscall
	
.end main