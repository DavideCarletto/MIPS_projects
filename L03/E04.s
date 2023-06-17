# • Si scriva un programma che conti il numero di bit a 1 nella rappresentazione binaria di una variabile di tipo halfword

.data
var: .half 546
message_out: .asciiz "IL numero di bit a 1 nella rappresentazione binaria del numero e' "

.text
.globl main
.ent main

main:

	lh $t0, var
	li $t3, 0
	
loop:

	andi $t2, $t0, 1	#Faccio andi tra var e 1 e metto il risultato in t2
	beq $t2, 1, incrementa	#Se i risultato è 1 incremento il contatore
	j shifta
	
incrementa:
	
	addi $t1, $t1, 1
	j shifta
	
shifta:
	
	srl $t0,$t0, 1
	addi $t3, $t3, 1
	bne $t3, 16, loop	#Se non sono ancora arrivato alla fine (devo aver fatto 16 shift) continuo il loop
	
fine:
	
	la $a0, message_out
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 10
	syscall
	
.end main