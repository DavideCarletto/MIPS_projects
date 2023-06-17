# • Date tre variabili word inizializzate in memoria, si scriva un programma che le stampi a video in ordine crescente
# – È possibile usare l’algoritmo descritto con il seguente pseudocodice:
# if (a > b)
# swap(a, b);
# if (a > c)
# swap(a, c);
# if (b > c)
# swap(b, c);

.data
A: .word 0
B: .word 0
C: .word 0
message_in: .asciiz "Inserire i 3 numeri da ordinare in modo crescente:\n"
message_out: .asciiz "I numeri ordinati sono:"
space: .asciiz ", "

.text
.globl main
.ent main

main:
	
	la $a0, message_in
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	
	sw $v0, A
	
	li $v0, 5
	syscall
	
	sw $v0, B
	
	li $v0, 5
	syscall
	
	sw $v0, C
	
swapAB:
	lw $t0, A
	lw $t1, B
	
	blt $t0, $t1, swapAC
	
	sub $t0, $t0, $t1
	add $t1, $t0, $t1
	sub $t0, $t1, $t0
	
	sw $t0, A
	sw $t1, B
	
swapAC:
	lw $t0, A
	lw $t2, C
	
	blt $t0, $t2, swapBC
	sub $t0, $t0, $t2
	add $t2, $t0, $t2
	sub $t0, $t2, $t0
	
	sw $t0, A
	sw $t2, C
	
swapBC:
	lw $t1, B
	lw $t2, C
	
	blt $t1, $t2, fine	
	
	sub $t1, $t1, $t2
	add $t2, $t1, $t2
	sub $t1, $t2, $t1
	
	sw $t1, B
	sw $t2, C
	
fine:
	la $a0, message_out
	li $v0, 4
	syscall
	
	li $v0,1
	lw $a0, A
	syscall 
	la $a0, space
	li $v0, 4
	syscall
	li $v0,1
	lw $a0, B
	syscall 
	la $a0, space
	li $v0, 4
	syscall
	li $v0,1
	lw $a0, C
	syscall 
	li $v0, 10
	syscall
	
.end main