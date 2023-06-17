# • Siano definite cinque variabili di tipo byte: 
# 	var1 = ‘m’, var2 = ‘i’, var3 = ‘p’, var4 = ‘s’, var5 = 0
# • Si scriva un programma che converta in  maiuscolo le prime 4 variabili.
# • Successivamente, stampare una stringa utilizzando la system call 4 e copiando in $a0  l’indirizzo di var1.
# • Quali sono i caratteri stampati a video? A cosa serve var5? 

.data

var1: .byte 'm'
var2: .byte 'i'
var3: .byte 'p'
var4: .byte 's'
var5: .byte 0

.text
.globl main
.ent main

main:

	lb $t0, var1;
	addi $t0, $t0, -32
	sb $t0, var1

	lb $t0, var2;
	addi $t0, $t0, -32
	sb $t0, var2
	
	lb $t0, var3;
	addi $t0, $t0, -32
	sb $t0, var3
	
	lb $t0, var4;
	addi $t0, $t0, -32
	sb $t0, var4
	
	la $a0, var1
	li $v0, 4
	syscall
	
	li $v0,10
	syscall
	
.end main