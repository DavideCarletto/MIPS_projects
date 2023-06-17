#• Scrittura di un valore in un registro e sua verifica su QtSpim.

#	• Vengono memorizzati
#	• $t0 valore 10 decimale
#	• $s0 valore DC esadecimale

.data
.text
.globl main
.ent main

main:

	li $t0, 10
	li $s0, 0xdc

	li $v0, 10
	syscall

.end main