# • Si scriva un programma in linguaggio MIPS che dica se un'equazione di secondo grado nella forma
# 𝑎𝑥^2 + 𝑏𝑥 + 𝑐 = 0
# abbia o meno soluzioni reali.
# • a, b e c sono interi con segno introdotti dall’utente.
# • Per i salti condizionati, si utilizzino soltanto le istruzioni slt, beq e bne.
# • Sia lecito assumere che i calcoli non diano overflow.

.data

message_in: .asciiz "Inserire i valori dell'equazione\n a: "
message_in2: .asciiz "b: "
message_in3: .asciiz "c: "
message_noSol: .asciiz "Non ci sono soluzioni\n"
message_Sol: .asciiz "Ci sono soluzioni\n"

.text
.globl main
.ent main

main:

    la $a0, message_in
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    la $a0, message_in2
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    la $a0, message_in3
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $t2, $v0

    mul $t3, $t1, $t1
    mul $t4, $t0, $t2
    sll $t4, $t4, 2

    sub $t3, $t3, $t4

    slt $t3, $t3, 0 # Questa istruzione mette in $t3 0 se $t3 è minore di 0 mentre mette 1 se è maggiore di 0.

    bne $t3, 0, noSol
    la $a0, message_Sol
    j print

noSol:
    
    la $a0, message_noSol
    j print

print:

    li $v0, 4
    syscall

fine:

    li $v0, 10
    syscall

.end main