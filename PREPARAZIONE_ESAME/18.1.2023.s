DIM=7 
.data 
vettore: .byte 11 5 1 4 6 2 12 
message_out: .asciiz "Risultato:"

.text 
.globl main 
.ent main 
main: 

    subu $sp, $sp, 4 
    sw $ra, ($sp) 
    
    la $a0, vettore 
    li $a1, DIM 
    jal EvenParity 

    move $s2, $v0

    la $a0, message_out
    li $v0, 4
    syscall 

    move $a0, $s2
    li $v0, 1
    syscall 

    lw $ra, ($sp) 
    addiu $sp, $sp, 4 
    jr $ra 

.end main

.ent EvenParity
    
    EvenParity:

        move $t0, $a0 #t0 contiene l'indirizzo del vettore
        li $t6, 0

        loop1: #faccio questa operazione per ogni byte

            li $t1, 4 #prendo i 4 bit meno significativi
            lb $t2, ($t0) #prendo il valore dell'indirizzo del vettore

            loop_2:
            and $t3, $t2, 1 #Faccio and per verificare se l'ultimo bit è un 1 e in caso affermativo incremento il contatore
            
            bne $t3, $0, salta_incrementa

            addi $t4, $t4, 1 #incremento il contatore di bit a 1

            salta_incrementa:
                srl $t2, $t2, 1 #scarto l'ultimo bit del numero
                addi $t1, $t1, -1 
                bgt $t1, 0, loop_2 
            
        lb $t2, ($t0)
        and $t4, $t4, 1
        beq $t4, 1, imposta_bit_a_1 #il contatore è dispari
        

        imposta_bit_a_0: #il contatore è pari 
            and $t2, $t2, 0x7F
            sb $t2, ($t0)
            addi $t5, $t5, 1 #counter elementi pari
            j successivo

        imposta_bit_a_1:
            ori $t2, $t2, 0x80
            sb $t2, ($t0)

        successivo:
            addi $t0, $t0, 1 # vado all'elemento successivo
            addi $t6, $t6, 1
            bne $t6, $a1, loop1 #continuo finché non esaurisco i valori nel vettore
        
        move $v0, $t5
        jr $ra

.end EvenParity










  
