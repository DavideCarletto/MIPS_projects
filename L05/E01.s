# Si scriva un programma in linguaggio Assembly MIPS che scriva in un vettore definito di 20 elementi di tipo word i primi 20 valori della serie di Fibonacci.
# • Serie di Fibonacci
# 	– vet[i] = vet[i-1] + vet[i-2] => vet = 1, 1, 2, 3, 5, 8, …

.data

NUM_ELEMENTI = 20
DIM = NUM_ELEMENTI*4

vett: .space DIM

message_out: .asciiz "\nLa sequenza di Fibonacci e':"
space: .asciiz ", "

.text
.globl main
.ent main

main:

	la $a0, message_out
	li $v0, 4
	syscall
	
	li $t1, 0 #contatore
	la $t2, vett #Indirizzo del vettore
	
	li $t0, 1
	sw $t0, ($t2)
	addi $t1, $t1, 1
	
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	addi $t2, $t2, 4
	sw $t0, ($t2)
	addi $t1, $t1, 1
	
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	
	li $t0, 0 #risultato delle somme
	
	bgt $t1, NUM_ELEMENTI, fine
	
ciclo: 
	
	lw $t0, ($t2)
	lw $t3, -4($t2)
	
	add $t0, $t0, $t3
	
	addi $t2, $t2, 4
	addi $t1, $t1, 1
	
	sw $t0, ($t2)
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall
	
	beq $t1, NUM_ELEMENTI, fine
	j ciclo
	


fine:

	li $v0, 10
	syscall
	
.end main