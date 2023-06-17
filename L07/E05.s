# • Nel calcolo combinatorio si definisce combinazione  semplice (senza ripetizioni) una presentazione di elementi di un insieme nella quale non ha importanza  l'ordine dei componenti e non si può ripetere lo stesso
# elemento più volte. Dati n elementi distinti e un numero intero positivo k ≤ n, il numero di combinazioni semplici possibili C(n, k) è dato dalla seguente formula:
# • Si scriva una procedura combina in grado di calcolare il numero di combinazioni semplici dati i parametri n e k ricevuti rispettivamente tramite $a0 e $a1. Il risultato dovrà essere restituito attraverso 
# il registro $v0.


.data

ask_for_n: .asciiz "Inserire il valore di n: "
ask_for_k: .asciiz "Inserire il valore di k: "
result: .asciiz "Numero di combinazioni semplici: "
new_line: .asciiz "\n"

.text
.globl main
.ent main


main:

    la $a0, ask_for_n
    li $v0, 4
    syscall

    li $v0 5
    syscall

    move $t0, $v0

    la $a0, ask_for_k
    li $v0, 4
    syscall

    li $v0 5
    syscall

    move $a0, $t0
    move $a1, $v0

    jal calcola
    
    move $t0, $v0

    la $a0, result
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, new_line
    li $v0, 4
    syscall

    j fine

calcola:

    move $t0, $a0 #Ci piazzo il valore di n
    move $t1, $a1 #Ci piazzo il valore di k

    li $t2, 0 # Counter_num

    li $t3, 1 #CurValNum
    li $t4, 1 #CurValDen

    ciclo_num:

        mult $t3, $t0
        mflo $t3

        addi $t2, $t2, 1
        addi $t0, $t0, -1

        bge $t2, $t1, ciclo_den

        j ciclo_num

    ciclo_den:

        mult $t4, $t1
        mflo $t4

        addi $t1, $t1, -1

        beq $t1, 0, calcola_div

        j ciclo_den

    calcola_div:

        div $t3, $t4
        mflo $v0
        jr $ra

fine:

    li $v0, 10
    syscall

.end main