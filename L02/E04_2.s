# • Ripetere l’operazione precedente, ma questa volta porre 40 nel registro $t2 e poi sommare $t1 e $t2. E’ possibile stampare a video un risultato numerico?
# Oss: con la add dà eccezione, con addu no ma stampa un risultato privo di significato--> la somma di due numeri positivi ne genera uno negativo --> overflow
.data

	var: .word 0x3FFFFFF0
	newline: .asciiz "\n"
.text
.globl main
.ent main

main:

	lw $t1, var
	add $t1, $t1, $t1
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $v0, 4       
	la $a0, newline
	syscall

	li $t2, 40
	addu $t2, $t1, $t2
	move $a0, $t2
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

.end main