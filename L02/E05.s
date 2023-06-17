# • Utilizzando la system call 5, leggere un intero introdotto tramite tastiera e salvarlo in $t1.
# • Leggere un altro intero e salvarlo in $t2.
# • Senza utilizzare altri registri, scambiare il valore di $t1 e $t2.
# • Suggerimento: utilizzare istruzioni di somma e sottrazione

.data 
	
	message_in: .asciiz "Inserire un intero:"
	message_in2: .asciiz "Inserire un altro intero:"
	message_out: .asciiz "Valori dei registri scambiati. Buona giornata :)"
.text
.globl main
.ent main

main:

	la $a0, message_in
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall

	move $t1, $v0
	
	la $a0, message_in2
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $t2, $v0
	
	sub $t1, $t1, $t2
	add $t2, $t1, $t2
	sub $t1, $t2, $t1
	
	la $a0, message_out
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

.end main