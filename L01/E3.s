#Somma di 2 valori contenuti in due variabili e  memorizzazione risultato in una variabile  Risultato
#• I due operandi
#• wOpd1: .word 10
#• wOpd2: .word 24
#• La variabile Risultato
#• wResult: .space 4

.data 

WOpD1: .word 10
WOpD2: .word 24
WResult: .space 4

.text
.globl main
.ent main

main:

	#la $t0, WOpD1 #carico sul registro t0 l'indirizzo di WOpD1
	lw $t1, WOpD1	#Leggo il valore di WOpD1 prendendolo da t0 e lo metto su t1
	#la $t0, WOpD2
	lw $t2, WOpD2
	
	add $t3, $t1, $t2 #sommo t1 e t2 e metto il risultato in t3
	
	#la $t0, WResult #carico su t0 il risultato
	sw $t3, WResult

	
	li $v0, 10
	syscall

.end main