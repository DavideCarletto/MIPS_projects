# • Si modifichino le due procedure implementate nell’esercizio precedente, in modo che ricevano come parametro la dimensione del  lato del triangolo e del quadrato.
# • Il parametro è passato attraverso il registro $a0.
# • All’inizio del main, chiedere all’utente la  dimensione del lato.


.data

messaggio: .asciiz "Inserisci la dimensione del lato: "

.text
.globl main
.ent main

main:
    # chiedi lato
    li $v0, 4
    la $a0, messaggio
    syscall

    # leggi lato
    li $v0, 5
    syscall

    # salva lato in $a0
    move $a0, $v0
    # stampa triangolo
    jal stampaTriangolo
    # stampa quadrato
    jal stampaQuadrato
    # exit
    j fine

stampaTriangolo:
    addi $sp, $sp, -4
    sw $a0, 0($sp)

    # $t0 = lato
    move $t0, $a0
    # $t1 = 0
    li $t1, 0
    # $t2 = 0
    li $t2, 0

    # while $t1 < $t0
while:
    slt $t3, $t1, $t0
    beq $t3, $zero, endwhile
    # $t2 = 0
    li $t2, 0
    # while $t2 < $t1

while2:
    slt $t3, $t2, $t1
    beq $t3, $zero, endwhile2
    # print *
    li $v0, 11
    li $a0, 42
    syscall
    # $t2++
    addi $t2, $t2, 1
    j while2

endwhile2:
    # print \n
    li $v0, 11
    li $a0, 10
    syscall
    # $t1++
    addi $t1, $t1, 1
    j while

endwhile:
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    # return
    jr $ra

stampaQuadrato:
    # $t0 = lato
    move $t0, $a0
    # $t1 = 0
    li $t1, 0
    # $t2 = 0
    li $t2, 0

    # while $t1 < $t0
whileQ:
    slt $t3, $t1, $t0
    beq $t3, $zero, endwhileQ
    # $t2 = 0
    li $t2, 0
    # while $t2 < $t0
while2Q:
    slt $t3, $t2, $t0
    beq $t3, $zero, endwhile2Q
    # print *
    li $v0, 11
    li $a0, 42
    syscall
    # $t2++
    addi $t2, $t2, 1
    j while2Q
endwhile2Q:
    # print \n
    li $v0, 11
    li $a0, 10
    syscall
    # $t1++
    addi $t1, $t1, 1
    j whileQ

endwhileQ:
# return
jr $ra

fine:
    li $v0, 10
    syscall

.end main