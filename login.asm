.model small
.stack 100h
.data
PRINT macro msg
    mov ah,09h
    lea dx,msg
    int 21h
    endm
false_login db 0
countLetter dw 0
success_loginMsg db 10,13,"You have successful login!$"
invalid_ID_password_Msg db 10,13,"You have entered invalid user id or password.",10,13,"Press any key to continue...$"
userId_Msg db 10,13,"User ID : $"
pw_Msg db 10,13,"Password : $"
id db "sportxpert$"
pw db "password$"


idArr LABEL BYTE 
MAX DB 30 
ACT DB ? 
input_idArr DB 30 DUP ('?') 

pwArr LABEL BYTE 
MAX_pwArr DB 30 
ACT_pwArr DB ? 
input_pwArr DB 30 DUP ('?')
 
.code
main proc
mov ax,@data
mov ds,ax

call login


mov ah,4ch
int 21h
main endp

login proc
username:
call cls
mov countLetter,0
mov false_login,0

PRINT userId_Msg

lea dx,idArr
mov ah,0ah
int 21h

mov si,0
mov cx,1
p1:
mov bl,[input_idArr+si]
cmp bl,13
je idclear
inc countLetter
inc si
inc cx
loop p1

idclear:
call clear
mov si,0
jmp validation_id

invalid_id:
inc false_login
jmp pass

validation_id:
mov cx,countLetter
mov bl,[input_idArr+si]
cmp [id+si],bl
jne invalid_id
inc si
dec countLetter
loop validation_id

cmp [id+si],"$"
jne invalid_id

pass:
PRINT pw_Msg

lea dx,pwArr
mov ah,0ah
int 21h

mov countLetter,0
mov si,0
mov cx,1
p2:
mov bl,[input_pwArr+si]
cmp bl,13
je pwclear
inc countLetter
inc si
inc cx
loop p2

pwclear:
call clear
mov si,0
jmp validation_pw

invalid_pw:
inc false_login
jmp checklogin

unssucessful:
PRINT invalid_ID_password_Msg
call pause
call CLS
jmp username

validation_pw:
mov cx,countLetter
mov bl,[input_pwArr+si]
cmp [pw+si],bl
jne invalid_pw
inc si
dec countLetter
loop validation_pw
cmp [pw+si],"$"
jne invalid_pw

checklogin:
cmp false_login,0
jg unssucessful

successful:
PRINT success_loginMsg

login endp

clear PROC          ;clear FUNCTION
xor ax,ax
xor bx,bx
xor cx,cx
xor dx,dx
ret
clear endp
newline proc        ;newline FUNCTION
mov ah, 02h
mov dl, 10
int 21h	
mov ah, 02h	
mov dl, 13
int 21h  
ret
newline endp
CLS proc            ;clear screen FUNCTION
    mov ah, 00 
    mov al, 02
    int 10h
    ret 
CLS endp


acceptChar PROC     ;acceptChar FUNCTION
mov ah,01h
int 21h
sub al,30h
ret
acceptChar endp 

printChar PROC      ;printChar FUNCTION
mov ah,02h
add dl,30h
int 21h
ret
printChar endp
pause proc
    push    cx
    push    ax
    push    dx
    push    bx
    mov     ah, 08h
    int     21h
    pop     bx
    pop     ax
    pop     dx
    pop     cx
    ret 
pause endp
end main


