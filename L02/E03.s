# • Siano date le seguenti variabili di tipo byte inizializzate in memoria:
# 	• op1: .byte 150
# 	• op2: .byte 100
# • Si stampi a video la somma delle due variabili, utilizzando la system call 1, e si verifichi che il risultato sia corretto.
# Abbiamo problemi con la rappresentazione perchè la somma è ai limiti della rappresentazione (2^8)--> se il numero è in complemento a due non dà il risultato corretto. 
# Bisogna quindi usare la lbu
# Da capire perchè basta usare la lbu solo su il primo operando e non sul secondo

.data 

op1: .byte 150
op2: .byte 100

.text
.globl main
.ent main

main:

	lbu $t0, op1
	lb $t1, op2

	add $a0, $t0, $t1
	
	li $v0,1
	syscall 
	
	li $v0, 10
	syscall

.end main