# Si scriva un programma che acquisisca DIM valori word e quindi ne calcoli la media (intera) e la stampi a video.
# – DIM deve essere dichiarato come costante
# – Si lavori nell’ipotesi di non avere overflow nei calcoli
# – Si noti il tipo di arrotondamento effettuato sul risultato della divisione.

.data

message_in: .asciiz "Inserire i numeri:\n"
message_out: .asciiz "Media: "
DIM = 5

.text
.globl main
.ent main

main:
	
	li $t0, 0	#Accumulatore
	li $t1, 0 	#Contatore
	
	la $a0, message_in
	li $v0, 4
	syscall
	
	j loop
	
loop:
	
	li $v0, 5
	syscall
	
	addu $t0, $t0, $v0 	#Sommo alla somma attuale il valore letto
	addu $t1, $t1, 1	#Incremento Contatore
	
	bne $t1, DIM, loop
	

	div $t0, $t0, DIM	#Divido (approssimazione per trocamento)
	
	la $a0, message_out
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
fine:

	li $v0, 10
	syscall
	
.end main
