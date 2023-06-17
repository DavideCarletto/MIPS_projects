# Si scriva un programma in grado di generare una tavola pitagorica (10x10) e memorizzarla.

.data

DIM = 10
mat: .space 100

message_err: .asciiz "Errore di overflow.\n"

.text
.globl main
.ent main

main:
	la $t0, mat
	li $t1, 1 		#	Contatore riga
	li $t2, 1 		# 	Contatore colonna
	
ciclo_riga:			

	li $t2, 1
	bne $t1, DIM, ciclo_colonna
	
	j fine

ciclo_colonna:
	
	mult $t1, $t2
	mfhi $t3
	
	bne $t3, $0, overflow
	
	mflo $t3
	sb $t3, mat($t0)
	
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	
	bne $t2, DIM, ciclo_colonna
	
	addi $t1, $t1, 1
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