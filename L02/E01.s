# • Siano definite le seguenti variabili di tipo byte già inizializzate in memoria:
# 	• n1: .byte 10
# 	• n2: .byte 0x10
# 	• n3: .byte '1'
# Sia inoltre definita la variabile di tipo byte, non inizializzata, res
# Si calcoli la seguente espressione e si verifichi il risultato: res = n1 - n2 + n3

.data
	
	n1: .byte 10	
	n2: .byte 0x10 #vale 16 in decimale
	n3: .byte '1' #vale 49 in decimale
	res: .space 1
	
.text
.globl main
.ent main

main:
	
	lb $t0, n1
	lb $t1, n2
	lb $t2, n3
	
	sub $t3, $t0, $t1
	add $t3, $t3, $t2
	
	sb	$t3, res
	
	li $v0, 1
	lb $a0, res
	syscall
	
	li $v0, 10
	syscall 
	
.end main