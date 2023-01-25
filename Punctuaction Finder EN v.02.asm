
org 100h 

.data
NameBuffer db 255, ?, 255 DUP ('$') 
newline db 0AH, 0DH, '$'
message1 db 'insert the message $'
messagefound db 'found a punctuation sign $' 
char2Check db ".,;:$"

.code 

mov DX, offset message1
mov ah, 09h
int 21h
         
mov dx, offset NameBuffer
mov ah, 0AH
int 21h

mov DX, offset newline 
mov ah, 09H 
int 21h 

mov DX, offset NameBuffer+2
mov ah, 09h
int 21h
 
 
mov DX, offset newline 
mov ah, 09H 
int 21h 

mov DI, offset NameBuffer+1
mov CX, [DI]
mov CH, 00H
CMP CX, 00H ; If the user presses enter the program end...
JZ stop
mov BX, offset NameBuffer+2

start:
    mov DL, [BX]
    ;Loop download characters in AH
    PUSH BX ; Save BX to read punctuation character...
    mov BX, offset char2Check

StartCharacter:    
    
    MOV AH, [BX]
    CMP AH, DL
    mov ah, 02  
    int 21h
    JZ found ; Jump on found if there is a punctuation character (0)
    
    INC BX
    CMP [BX], '$'
    JZ nextChar
    JMP StartCharacter 
    
nextChar:
    pop BX  ; Recover BX that I need to scroll through the string characters to check...
    inc BX
   
loop start
JMP stop

found:
    ; I have to print that I found a character...
    mov DX, offset messagefound
    mov ah, 09h
    int 21h
    ; New line    
    mov DX, offset newline 
    mov ah, 09H 
    int 21h
    JMP nextChar  ;When a punctuation character is found and printed it goes back to the next character    

stop:
       
ret




