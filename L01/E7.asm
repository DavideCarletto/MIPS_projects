# • Ricerca del carattere minimo, vengono inseriti da tastiera DIM valori, si calcola il minimo e si  visualizza
# • Registri
	# – $t0. Indirizzo Vettore
	# – $t1. Contatore
	# – $t2. Valore Minimo
	# – $t3. Temporaneo

# Problema: se il curmin è il penultimo numero e l'ultimo elemento è minore non aggiorna il minimo

.data 

	DIM=4
wVet: .space 20
wRes: .space 4
message_in: .asciiz "Inserire numeri\n"
message_out: .asciiz "Valore Minimo: "

.text
.globl main
.ent main

main:

	la $t0, wVet
	li $t1, 0
	
	la $a0, message_in
	li $v0, 4
	syscall
	
uno: 
	
	li $v0 5
	syscall
	sw $v0, ($t0)
	beq $t1, DIM, calc
	add $t1, $t1, 1
	add $t0, $t0, 4
	j uno
	
calc: 

	la $t0, wVet
	li $t1, 0
	lw $t2, ($t0)
	
loop_min:

	beq $t1, DIM, print_num
	lw $t3, ($t0)
	blt $t3, $t2, change_min
	add $t1, $t1, 1
	add $t0, $t0, 4
	j loop_min
	
print_num:

	la $a0, message_out
	li $v0, 4
	syscall	#Stampo a video message_out
	
	li $v0,1
	lw $a0, wRes
	syscall

	j fine
	
change_min:

	la $t2, ($t3)
	sw $t2, wRes
	j loop_min
	
fine:
	li $v0, 10
	syscall
	
.end main
