# • Il costo di un parcheggio è pari a X Euro per ogni periodo di Y minuti. Per eventuali minuti di un periodo non completo sono addebitati comunque X Euro.
# – X: 1 Euro Y: 40 minuti
# – Orario di ingresso: 12.47 Orario di uscita: 18.14
# – Il tempo di permanenza corrisponde a 8 periodi interi più 7 minuti. Il costo del parcheggio è 9 Euro.
# • Si scriva una procedura costoParcheggio in linguaggio assembly MIPS32 in grado di calcolare il costo per il parcheggio.
# • Gli orari di ingresso e di uscita sono memorizzati ciascuno in un vettore di 2 byte: il primo indica l’ora e il secondo i minuti. La procedura costoParcheggio riceve 
# l’indirizzo dei due vettori tramite i registri $a0 e $a1, X e Y mediante $a2 e $a3, e restituisce il costo del parcheggio attraverso $v0.
# • Si assuma che gli orari siano sempre consecutivi e appartenenti alla stessa giornata.

.data

ora_ingresso: .byte 12, 47
ora_uscita: .byte 18, 14

X: .byte 1
Y: .byte 40

message_out: .asciiz "Costo del parcheggio: "
message_out2: .asciiz " Euro.\n"
.text
.globl main
.ent main

main:
    subu $sp, $sp, 4
    sw $ra, ($sp)

    la $a0, ora_ingresso
    la $a1, ora_uscita 

    lb $a2, X
    lb $a3, Y

    jal costoParcheggio

    move $t0, $v0

    la $a0, message_out
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall 
    
    la $a0, message_out2
    li $v0, 4
    syscall

    lw $ra, ($sp)
    addu $sp, $sp, 4
    jr $ra

.end main


.ent costoParcheggio

costoParcheggio:

    subu $sp, $sp 20

    sw $s0, 16($sp)
    sw $s1, 12($sp)
    sw $s2, 8($sp)
    sw $s3, 4($sp)
    sw $s4, ($sp)

    lb $s0, ($a1)
    lb $s1, 1($a1)
    move $s3, $a2
    move $s4, $a3

    li $t0, 0
    addi $t0, $t0, 60

    mult $s0, $t0
    mflo $s0

    add $s0, $s0, $s1
    
    lb $s1, ($a0)
    lb $s2 1($a0)

    mult $s1, $t0
    mflo $s1

    add $s1, $s1, $s2

    sub $s0, $s0, $s1

    div $s0, $s4

    mflo $s0
    mfhi $s1
    
    beq $s1, 0, calcola_prezzo

    addi $s0, $s0, 1

calcola_prezzo:

    mult $s0, $s3
    mflo $s0

    move $v0, $s0
    
    lw $s4, ($sp)
    lw $s3, 4($sp)
    lw $s2, 8($sp)
    lw $s1, 12($sp)
    lw $s0, 16($sp)

    addu $sp, $sp, 20

    jr $ra

.end costoParcheggio