# • Lettura da tastiera e visualizzazione a video di un vettore di 5 caratteri
# • Registri
	# – $t0. Indirizzo Vettore
	# – $t1. Contatore
	# – Syscall ($v0=1).Print integer($a0 = integer)
	# – Syscall ($v0=4).Print string ($a0 = string) 
	# – Syscall ($v0=5).Get integer ($v0 = integer)
# • Tipo asciiz - NULL terminated ASCII string
	# – .asciiz "Inserire numeri\n"
# • Il NULL è un carattere ASCII non stampabile e 
# viene utilizzato per contrassegnare la fine 
# della stringa. La terminazione NULL è standard 
# ed è richiesta dal servizio di sistema della 
# stringa di stampa (per funzionare 
# correttamente).
# • Get Integer, si chiude con un ENTER
# • Non viene eseguito nessun controllo su tipo di 
# carattere inserito ( ovvero se corrisponde ad 
# una cifra numerica)
	# – li $v0, 5 
	# – syscall #(result in $v0)
	# – sw $v0, ($t0)

.data

DIM = 4
wRes: .space 20 #5 caratteri, da 0 a 4, quindi ci servono 20 byte
message_in: .asciiz "Inserire numeri\n"
message_out: .asciiz "Numeri inseriti\n"
space: .ascii " ; "

.text
.globl main
.ent main

main:

	la $a0, message_in
	li $v0, 4
	syscall  # Questo pezzo serve per stampare a video message_in
	
	la, $t0, wRes
	li $t1, 0
	
uno: 
	
	li $v0, 5 #legge un integer
	syscall	
	sw $v0, ($t0) #La syscall resitutisce quello che si scrive in v0 e noi lo piazziamo in t0
	beq $t1, DIM, print_num
	add $t1, $t1, 1
	add $t0, $t0, 4
	j uno
	
print_num:

	la $a0, message_out
	li $v0, 4
	syscall		#Stampo a video message_out
	
	sw $t2, wRes
	la $t0, wRes
	li $t1, 0
	
ciclo_print:
	
	li $v0,1 #Bisogna inizializzarla tutte le volte perchè la syscall ritorna sempre qualcosa e può "sporcare" v0
	lw, $a0, ($t0)
	syscall
	
	beq $t1, DIM, fine
	la $a0, space
	li $v0, 4
	syscall
	
	add $t1, $t1 1
	add $t0, $t0 4
	j ciclo_print
	
fine:
	
	nop
	li $v0, 10
	syscall
	
.end main