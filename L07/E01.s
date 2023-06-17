# • Si scriva una procedura stampaTriangolo che mostra a video un triangolo rettangolo isoscele di lato 8, tramite una opportuna sequenza di asterischi.
# • Si scriva una procedura stampaQuadrato che mostra a video un quadrato di lato 8, tramite una opportuna sequenza di asterischi.
# • A destra è mostrato l’output ottenuto richiamando le due procedure dal main.

.data

.text
.globl main
.ent main

main:
    # stampa triangolo
    jal stampaTriangolo
    # stampa quadrato
    jal stampaQuadrato
    # exit
    li $v0, 10
    syscall

stampaTriangolo:
    # $a0 = lato
    li $a0, 8
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
# return
jr $ra

stampaQuadrato:

    # $a0 = lato
    li $a0, 8
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

.end main