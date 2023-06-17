#• Somma degli elementi di un Vettore (I)
	#– wVett: .word 5, 7, 3, 4,
#• Risultato in una variabile Risultato
	#– wResult: .space 4
#• Tecnica molto semplice fatta di somme  successive con utilizzo di un Registro come accumulatore.
	#– $t1 ACCUMULATORE
	#– $t0 INDIRIZZO Vettore
	#– $t2 Secondo OPERANDO


.data

wVett: .word 5, 7, 3, 4, 3
wResult: .space 4

.text
.globl main
.ent main

main:
	
	li $t1, 0 #inizializzo t1
	la $t0, wVett #carico in t0 l'indirizzo di wVett

	lw $t2, ($t0) #metto in t2 quello che c'è in t0 (valore di wVett all'iesimo posto)
	add $t1, $t1, $t2 #sommo t1 e t2 e metto il risultato in t1 
	addi $t0, $t0, 4	#vado sull'(i+1)-esimo elemento

	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, $t0, 4

	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, $t0, 4

	lw $t2, ($t0)
	add $t1, $t1, $t2
	addi $t0, $t0, 4

	lw $t2, ($t0)
	add $t1, $t1, $t2
	sw $t1, wResult #scrivo in memoria il valore di t1
	

	li $v0, 10
	syscall
.end main

