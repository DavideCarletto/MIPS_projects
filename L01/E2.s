#• Scrittura di un valore in una cella di memoria
#• Dichiarazione della variabile inizializzata con il valore 3 decimale
#• wVar: .word 3

.data
	wVar: .word 3
.text
.globl main
.ent main

main:
	
	li $t0, 10 #inizializzo con un valore che non sia 3
	sw $t0, wVar #prendo il valore in t0 e lo scrivo in memoria
	
	li $v0,10
	syscall

.end main