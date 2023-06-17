# Si scriva un programma MIPS che, dati due vettori di 4 word ciascuno come matrici riga e colonna, ne calcoli il prodotto.
# • Si ricorda che
#	 Se x = (x1,x2, …, xn) e y = (y1, y2, …, yn) sono due vettori a n componenti, il prodotto fra il vettore colonna x e il vettore riga y coincide con la matrice di ordine 
#	 n·n in cui l’elemento di indice ij è dato dal prodotto tra la i-esima componente di x e la j-esima componente di y.

.data

NUM_ELEMENTI = 4
DIM = NUM_ELEMENTI*4

x: .word 12, 56, 1, 5
y: .word 51, 11, 0, 4

mat: .space DIM * NUM_ELEMENTI

message_err: .asciiz "Errore di overflow.\n"

.text
.globl main
.ent main

main:
	li $t0, 0		# 	In t0 Offset della matrice
	li $t1, 0 		#	Contatore riga
	li $t2, 0 		# 	Contatore colonna
	
ciclo_riga:			# 	Moltiplico ogni elemento di x per tutti gli elementi di y

	lw $t3, x($t1)	#	In $t3 piazzo il valore di x
	li $t2, 0
	bne $t1, DIM, ciclo_colonna
	
	j fine

ciclo_colonna:
	
	lw $t4, y($t2)

	mult $t3, $t4
	mfhi $t4
	
	bne $t4, $0, overflow
	
	mflo $t4
	sw $t4, mat($t0)
	
	addi $t0, $t0, 4
	addi $t2, $t2, 4
	
	bne $t2, DIM, ciclo_colonna
	
	addi $t1, $t1, 4
	j ciclo_riga

overflow:

	la $a0, message_err
	li $v0, 4
	syscall 
	
	j fine
	
fine:

	li $v0, 10
	syscall
	
.end main