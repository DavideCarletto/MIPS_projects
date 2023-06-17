# Si modifichi l’esercizio precedente per la lettura robusta di un numero intero unsigned tramite la system call 12.
# • Oltre a verificare se i caratteri introdotto siano cifre, il programma deve controllare se il numero sia rappresentabile su 4 byte.
# • Il programma termina quando è letto ‘\n’; il numero introdotto in input deve essere stampato a video tramite la system call 1

.data
message_in: .asciiz "Inserire un numero intero senza segno:\n"
message_err: .asciiz "\nErrore: non hai inserito un intero!\n"
message_err_overflow: .asciiz "\nErrore di overflow\n"
message_err_not: .asciiz "\nNumero non rappresentabile!\n"
message_out: .asciiz "Numero inserito: "
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
	
	beq $t0, '\n', print_int	#Finisco quando il viene letto \n
	
	sub $t0, $t0, '0'
	
	blt $t0, 0, print_err
	bgt $t0, 9, print_err
	
	multu $t1, $t3	
	mfhi $t2	#Trasferisco il risultato della moltiplicazione da hi a t2
	bne $t2, $0, print_err_overflow	#Se t2 non è zero significa che c'è stato overflow
	mflo $t1	#Trasferisco il risultato della moltiplicazione da lo a t2
	
	addu $t1, $t0, $t1
	bltu $t1, $t0, print_err_overflow
	
	j read_int

print_err:
	la $a0, message_err
	li $v0, 4
	syscall
	
	j fine


print_err_overflow:
	la $a0, message_err_not
	li $v0, 4
	syscall
	
	j fine

print_int:

	la $a0, message_out
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
	
	j fine
	
fine:
	
	li $v0, 10
	syscall

.end main