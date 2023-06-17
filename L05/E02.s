# Scrivere un programma che, dati due operandi opa e opb di tipo word in memoria, del valore rispettivo di 2043 e 5, esegua un’operazione tra interi scelta dall’utente e salvi il risultato nella variabile word res
# • A seconda dell’intero digitato dall’utente, il programma deve eseguire:
#  	- 0 -> res = a+b
# 	- 1 -> res = a-b
# 	- 2 -> res = a*b
# 	- 3 -> res = a/b (divisione intera).

.data

opa: .word 2043
opb: .word 5
res: .space 4

tab: .word somma, sottrazione, moltiplicazione, divisione

message_in: .asciiz "Inserire l'operazione da eseguire:"
message_out: .asciiz "Fine Programma.\n\n"
message_res: .asciiz "Risultato operazione:"
space: .asciiz "\n"

.text
.globl main
.ent main

main:

	li $t0, 0
	li $t1, 0
	
	la $a0, message_in
	li $v0, 4
	syscall 
	
	li $v0, 5
	syscall
	
	
	bgt $v0, 3, fine
	blt $v0, 0, fine
	
	mul $t0, $v0, 4
	
	lw $t2, tab($t0)
	jr $t2

somma:
	
	lw $t0, opa
	lw $t1, opb
	
	add $t0, $t0, $t1
	j stampa
	
sottrazione:

	lw $t0, opa
	lw $t1, opb
	
	sub $t0, $t0, $t1
	j stampa
	
moltiplicazione:

	lw $t0, opa
	lw $t1, opb
	
	mul $t0, $t0, $t1	
	j stampa
	
divisione:

	lw $t0, opa
	lw $t1, opb
	
	div $t0, $t0, $t1
	j stampa
	
stampa:

	sw $t0, res
	
	la $a0, message_res
	li $v0, 4
	syscall 
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	la $a0, space
	li $v0, 4
	syscall 
	
	j main

fine: 

	la $a0, message_out
	li $v0, 4
	syscall 
	
	li $v0, 10
	syscall
	
.end main
