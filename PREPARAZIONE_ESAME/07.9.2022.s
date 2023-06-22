
.data 
    stringa1: .asciiz "calcolatori elettronici"
    stringa2: .asciiz "raccolta"
    message_out: .asciiz "Risulato: "
.text 
.globl main 
.ent main 

main: 
    subu $sp, $sp, 4 
    sw $ra, ($sp) 

    la $a0, stringa1 
    la $a1, stringa2 

    jal cercaSequenza 

    move $s0, $v0
    
    la $a0, message_out
    li $v0, 4
    syscall

    move $a0, $s0
    li $v0, 1
    syscall

    lw $ra, ($sp) 
    addiu $sp, $sp, 4 
    jr $ra 

.end main

.ent cercaSequenza

cercaSequenza:
    
    loop1: #parto dalla stringa intera e mano mano la riduco in modo da cercare sequenze

        lb $t0, ($a1) #leggo il carattere da cui partire, se è \0 termino il programma 
        beq $t0, 0, fine
        la $t1, ($a1) #prendo l'indirizzo di a1 che andrò a incrementare man mano
        li $t5, 0 #resetto il contatore
        move $t3, $a0 #prendo tutta la stringa 1 come riferimento per il conteggio 

        loop2:
            lb $t2, ($t1) #carico il carattere corrente della stringa 2
            beq $t2, 0, terminaRicercaInStringa #Se arrivo il fondo smetto di ricerca occorrenze

            cercaInStringa1:
                lb $t4, ($t3) #prendo il carattere corrente a cui sono arrivato precedetemente della stringa 1 per analizzare la sequenza 
                beq $t4, 0, terminaRicercaInStringa #Significa che non ci sono più valori nella sequenza
                beq $t4, $t2 incrementaContatore #se i due caratteri sono uguali ho trovato un carattere della sequenza

                addi $t3, $t3, 1
                j cercaInStringa1

                incrementaContatore:
                addi $t5, $t5, 1 #Incremento il numero di occorrenze
                addi $t1, $t1, 1 #Cerco dalla stringa 2 il carattere successivo che sarà da ricercare in stringa 1
                addi $t3, $t3, 1 #Incremento il riferimento a cui partire per la ricerca del carattere successivo
                j loop2

            terminaRicercaInStringa:
                blt $t5, $t6, SkipswapMax
            
                move $t6, $t5 #Signfica che il valore corrente è maggiore del valore massimo trovato precedentemente

            SkipswapMax:
                addi $t1, $t1, 1 #prendo il carattere successivo della sequenza

            addi $a1, $a1, 1
            
        j loop1

    fine:
    move $v0, $t6
    jr $ra
.end cercaSequenza