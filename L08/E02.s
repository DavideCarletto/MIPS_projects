# • Si consideri una sequenza di numeri naturali in cui, scelto il primo numero della sequenza 𝑐0, gli elementi successivi sono così ottenuti:
# 𝑐𝑖+1 = 
# 𝑐𝑖/2 𝑠𝑒 𝑐𝑖 è 𝑝𝑎𝑟𝑖
# 3 ∗ 𝑐𝑖 +1 𝑠𝑒 𝑐𝑖 è 𝑑𝑖𝑠𝑝𝑎𝑟𝑖
# • Si scriva una procedura calcolaSuccessivo che riceva tramite $a0 un numero naturale e calcoli l’elemento successivo della sequenza. Tale numero è stampato a video e restituito attraverso $v0

.data

message_in: .asciiz "Inserire il numero della successione:"
message_out: .asciiz "Il numero successivo della sequenza e': "
new_line: .asciiz "\n"

.text
.globl main
.ent main

main:
    
    addi $sp, $sp, -4
    sw $ra, ($sp)

    la $a0, message_in
    li $v0, 4
    syscall

    li $v0, 5
    syscall

    move $a0, $v0

    jal calcolaSuccessivo
    
    lw $ra, ($sp)
    addiu $sp, $sp, 4

    move $t0, $v0

    la $a0, message_out
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, new_line
    li $v0, 4
    syscall

    jr $ra

    .end main

.ent calcolaSuccessivo
calcolaSuccessivo:

    andi $t0, $a0, 1
    bnez $t0, dispari

    pari:
        
        sra $a0, $a0, 1
        move $v0, $a0
        jr $ra

    dispari:
        
        mul $a0, $a0, 3
        add $a0, $a0, 1
        move $v0, $a0
        jr $ra
    .end calcolaSuccessivo