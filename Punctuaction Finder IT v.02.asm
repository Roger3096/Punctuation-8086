
org 100h 

.data
NomeBuffer db 255, ?, 255 DUP ('$') 
tornaacapo db 0AH, 0DH, '$'
messaggio1 db 'inserisci il testo $'
messaggiotrovato db 'trovato un segno di punteggiatura $'
char2Check db ".,;:$"

.code 

mov DX, offset messaggio1
mov ah, 09h
int 21h
         
mov dx, offset NomeBuffer
mov ah, 0AH
int 21h

mov DX, offset tornaacapo 
mov ah, 09H 
int 21h 

mov DX, offset NomeBuffer+2
mov ah, 09h
int 21h
 
 
mov DX, offset tornaacapo 
mov ah, 09H 
int 21h 

mov DI, offset NomeBuffer+1
mov CX, [DI]
mov CH, 00H
CMP CX, 00H ; Se l'utente inserisce subito un enter, devo saltare subito alla fine...
JZ finito
mov BX, offset NomeBuffer+2

inizio:
    mov DL, [BX]
    ;ciclo caricamento cararatteri punteggiatura in AH
    PUSH BX ; salvo BX che utilizzero per scorrere i carartteri di punteggiatura...
    mov BX, offset char2Check

inizioCarPunt:    
    
    MOV AH, [BX]
    CMP AH, DL
    mov ah, 02  
    int 21h
    JZ trovato ;salta a trovato se risulta che ci sia un segno di punteggiatura(0)
    
    INC BX
    CMP [BX], '$'
    JZ nextChar
    JMP inizioCarPunt 
    
nextChar:
    pop BX  ; recupero BX che mi serve per scorrere i carartteri della stringa da controllare...
    inc BX
   
loop inizio
JMP finito

trovato:
    ; Devo stampare a video che ho trovato un carattere
    mov DX, offset messaggiotrovato
    mov ah, 09h
    int 21h
    ; Torna a capo    
    mov DX, offset tornaacapo 
    mov ah, 09H 
    int 21h
    JMP nextChar  ;quando un carattere viene individuato il programma salta su nextChar per passare al prossimo carattere    

finito:
       
ret




