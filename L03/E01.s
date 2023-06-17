# • Si scriva un programma che richieda all’utente un intero positivo e quindi dica se il valore introdotto è pari oppure dispari
# • Per la determinazione del pari/dispari si utilizzi un’operazione di AND logico con il  valore 1


.data

var: .space 4
message_in: .asciiz "Inserire un intero positivo:\n"
message_out_p: .asciiz "Il numero inserito e' pari."
message_out_d: .asciiz "Il numero inserito e' dispari."

.text
.globl main
.ent main

main:

	la $a0, message_in
	li $v0, 4
	syscall 
	
	la, $t0, var
	li $t1, 0
	
	li $v0, 5
	syscall	
	
	sw $v0, ($t0) #Per il momento in t0 c'è l'indirizzo di var 
	lw $t0, var #Ora in t0 c'è il valore di var

	and $t1, $t0, 1
	beq $t1, $0, stampaPari

	la $a0, message_out_d
	li $v0, 4
	syscall
	j fine
	
stampaPari:
	
	la $a0, message_out_p
	li $v0, 4
	syscall
	
fine:

	li $v0,10 
	syscall

.end main