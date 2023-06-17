#• Somma degli elementi di un Vettore (II) con un loop
#• Registri
	#– $t0. Indirizzo Vettore
	#– $t1. Accumulatore
	#– $t2. Temporaneo
	#– $t3. Contatore


.data 

	DIM = 15 
	wVett: .word 2 ,5, 16, 12, 34, 7, 20, 11, 31, 44, 70, 69, 2, 4, 23
	wResult: .space 4

.text
.globl main
.ent main

main:

	li $t1, 0
	li $t3, DIM
	la $t0, wVett

ciclo: 
	
	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, $t0, 4
	sub $t3, $t3, 1
	beq $t3, 0, fine
	j ciclo

fine: 	
	
	sw $t1, wResult

	li $v0, 10
	syscall
	.end main
	