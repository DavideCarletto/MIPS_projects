# La system call 5 permette di leggere in input un numero intero con segno.
# • Cosa succede se l’utente introduce da tastiera un carattere non numerico?
# • Si realizzi un programma per effettuare una lettura robusta di un numero intero unsigned.
# • Il programma legge singoli caratteri tramite la system call 12, verifica se sono cifre e termina quando l'utente preme ‘\n’ (invio).

.data
message_in: .asciiz "Inserire un numero intero senza segno:"
message_err: .asciiz "\nErrore: non hai inserito un intero!"
message_err_overflow: .asciiz "\n Errore di overflow"

.text
.globl main
.ent main

main:

	la $a0, message_in
	li $v0, 4
	syscall
	
	li $t0, 0
	li $t1, 0
	li $t3, 10
read_int:

	li $v0, 12
	syscall
		
	move $t0, $v0 #valore letto 
	
	beq $t0, '\n', fine
	
	sub $t0, $t0, '0'
	
	blt $t0, 0, print_err
	bgt $t0, 9, print_err
	
	multu $t1, $t3
	mfhi $t2
	bne $t2, $0, print_err_overflow
	mflo $t1
	
	add $t1, $t0, $t1

	j read_int

print_err:
	la $a0, message_err
	li $v0, 4
	syscall
	
	j fine


print_err_overflow:
	la $a0, message_err_overflow
	li $v0, 4
	syscall
	
	j fine
	
fine:

	li $v0, 10
	syscall

.end main