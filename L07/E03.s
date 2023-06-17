# • Si scriva un programma per la conversione di una parola di caratteri minuscoli in caratteri maiuscoli, attraverso un’opportuna procedura.
# • Si passi alla procedura il codice ASCII di un carattere alla volta come parametro by value utilizzando il registro $a0; il carattere convertito è restituito attraverso $v0.

.data

message: .asciiz "Inserire i caratteri da convertire:\n"
arrow: .asciiz " -> "
space: .asciiz "\n"
end: .asciiz "fine\n"
.text
.globl main
.ent main

 main:

    li $v0, 4
    la $a0, message
    syscall
    
    li $v0, 12
    syscall

    beq $v0, '\n', fine

    jal converti

    move $a0, $v0
    li $v0, 11
    syscall

    la $a0, space
    li $v0, 4
    syscall 

    j main

converti:

    move $a0, $v0
    addi $a0, $a0, -32
    
    addi $sp, $sp, -4
    sw $a0, 0($sp)

    la $a0, arrow
    li $v0, 4
    syscall 

    lw $a0, 0($sp)
    addi $sp, $sp, 4

    move $v0, $a0
    jr $ra

 fine:
     la $a0, fine
    li $v0, 4
    syscall 
    li $v0, 10
    syscall

.end main
