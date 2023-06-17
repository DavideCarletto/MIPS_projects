# • Sia data la seguente variabile di tipo word  inizializzata in memoria:
# 	var: .word 0x3FFFFFF0
# • Si memorizzi nel registro $t1 il doppio del valore di var e poi lo si stampi a video.
# • Aggiungere a $t1 il valore immediato 40 (usando un altro registro come destinazione per non modificare $t1). Cosa accade? E’ possibile stampare un risultato numerico?
# Add, addi scatenano eccezione, addu no ma risultato privo di significato

# Spiegazione del perchè si vede risultato negativo (da Telegram): "Qtspim ti fa vedere il risultato con un numero negativo, perché sostanzialmente 
#quando si eccede il massimo numero rappresentabile è come se ripartisse dal basso, e quindi dal minor numero rappresentabile, andando ad aggiungere ciò che mancava prima"

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
	
	addiu $a0, $t1, 40
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall

.end main