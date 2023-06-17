# • Si scriva un programma che
# – Acquisisca due interi positivi
# – Verifichi che gli interi acquisiti siano rappresentabili su byte, e in questo caso esegua la seguente operazione logica bitwise e scriva sulla console il risultato ottenuto (intero):
# C = NOT(A AND (NOT(B))) OR (A XOR B)
# – Altrimenti, dia un messaggio di errore.

.data
message_in: .asciiz "Inserire 2 numeri interi:\n"
message_err: .asciiz "Errore: numeri non rappresentabili su byte"
message_out: .asciiz "Risultato ottenuto:"
.text
.globl main
.ent main

main:
	
	la $a0, message_in
	li $v0, 4
	syscall
	
	li $t0, 255
	
	li $v0, 5
	syscall	
	move $t1, $v0
	
	li $v0, 5
	syscall	
	
	move $t2, $v0
	
	bgt $t1, $t0, error
	blt $t1, $0, error
	bgt $t2, $t0, error
	blt $t2, $0, error

	li $t3, -1			#In questo registro salvo -1 perchè se faccio xor tra registro e -1 ottengo il not
	xor $t4, $t2, $t3
	and $t4, $t1, $t2
	xor $t4, $t4, $t3
	xor $t5, $t1, $t2
	or $t4, $t4, $t5	#Il risultato dell'operazione è in t4
	
	la $a0, message_out
	li $v0, 4
	syscall
	li $v0, 1
	move, $a0, $t4
	syscall
	j fine
	
error:
	
	la $a0, message_err
	li $v0, 4
	syscall

	
fine:
	
	li $v0, 10
	syscall
.end main

