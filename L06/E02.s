# • Si scriva un programma che verifichi se la stringa introdotta dall’utente è palindroma.
# • La lettura dell’input avviene un carattere alla volta tramite la system call 12 e termina quando l’utente introduce ‘\n’.
# • Il numero di caratteri introdotto dall’utente non è noto a priori, quindi si utilizzi lo stack per memorizzarli invece di allocare una quantità di memoria costante.

.data

inputMsg: .asciiz "Inserire un parola: "
noPalindromaMsg: .asciiz "La parola inserita non e' palindroma\n"
palindromaMsg: .asciiz "La parola inserita e' palindroma\n"

.text
.globl main
.ent main

main:

    li $t0, 0 # Contatore lettere
    move $t1, $sp

    la $a0, inputMsg
    li $v0, 4
    syscall

loop_read:

    li $v0, 12
    syscall

    addi $t0, $t0, 1
    addi $sp, $sp, -4
    sb $v0, 0($sp)


    bne $v0, '\n', loop_read
    addi $sp, $sp, 4
    addi $t1, $t1, -4
check_palindroma:

    lb $t2, 0($t1)
    lb $t3, 0($sp)

    addi $t1, $t1, -4
    addi $sp, $sp, 4

    bne $t2, $t3, noPalindroma

    addi $t0, $t0, -2

    bgt $t0, 1, check_palindroma
    j palindroma

noPalindroma:

    la $a0, noPalindromaMsg
    li $v0, 4
    syscall

    j fine

palindroma:

    la $a0, palindromaMsg
    li $v0, 4
    syscall

fine: 

    li $v0, 10
    syscall

.end main