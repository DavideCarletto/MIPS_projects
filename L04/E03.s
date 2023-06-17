# Siano date tre variabili di tipo byte in memoria, che rappresentino rispettivamente il numero di giorni, ore e minuti passati da un certo istante T0.
# • Si calcoli il numero totale di minuti passati da T0, e tale valore sia salvato nella variabile di tipo word risultato.
# • È possibile ottenere overflow durante i calcoli?

.data

res: .byte 0
giorni: .byte 22
ore: .byte 21
minuti: .byte 10
message_err_overflow: .asciiz "Errore di overflow!\n"
.text
.globl main
.ent main

main:

	lb $t1, giorni
	li $t2, 24
	
	multu $t1, $t2	#Ottengo il numero di minuti per i giorni corrispondenti
	mfhi $t2
	bne $t2, $0, print_err_overflow
	mflo $t0
	
	lb $t1, ore
	li $t2, 60
	
	multu $t1, $t2	#Ottengo il numero di minuti per le ore corrispondenti
	mfhi $t2
	bne $t2, $0, print_err_overflow
	mflo $t1
	addu $t0, $t0, $t1	#Sommo all'accumulatore (t0)
	
	lb $t1, minuti
	addu $t0, $t0, $t1
	
	sw $t0, res
	
	j fine
	
print_err_overflow:

	la $a0, message_err_overflow
	li $v0, 4
	syscall
	
	j fine

fine:

	li $v0, 10
	syscall
	
.end main
