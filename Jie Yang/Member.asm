.model small
.stack 100
.data
;print
    print macro sout
        mov ah, 09h
        lea dx, sout
        int 21h
    endm
 
;membershipMenu
display_membership_menu db 10, 13, "          ----------------------------------------"
                        db 10, 13, "          |             Member Menu              |"
                        db 10, 13, "          ----------------------------------------"
                        db 10, 13, "          |                                      |"
                        db 10, 13, "          |        1. Register Membership        |"
                        db 10, 13, "          |        2. Display Member             |"
                        db 10, 13, "          |        3. Exit                       |"
                        db 10, 13, "          |                                      |"
                        db 10, 13, "          ----------------------------------------$"
                                                
member_option db 10, 13, "Enter an option: $"

display_register_membership_menu db 10, 13, "          -----------------------------------------------------"
                                 db 10, 13, "          |                 Register Membership               |"
                                 db 10, 13, "          -----------------------------------------------------"
                                 db 10, 13, "          |                                                   |"
                                 db 10, 13, "          |         1. Bronze Membership (5% discount)        |"
                                 db 10, 13, "          |         2. Silver Membership (10% discount)       |"
                                 db 10, 13, "          |         3. Gold Membership (15% discount)         |"
                                 db 10, 13, "          |         4. Exit                                   |"
                                 db 10, 13, "          |                                                   |"
                                 db 10, 13, "          -----------------------------------------------------$"
                                 
prompt_enter_name db 10, 13, "Enter your name: $"
name db 100 dup(?)
prompt_enter_age db 10, 13, "Enter your age: $"
age db 100 dup(?)

display_error_message db 10, 13, "Please only input effective number!$"
                        
.code
main proc
mov ax, @data
mov ds, ax  

;----------------------------------------display member menu, prompt and read option
          
memberMenu:          
mov ah, 00
mov al, 02
int 10h

print display_membership_menu
print member_option

mov ah, 01h
int 21h 

mov bl, al

cmp bl, 31h
jge checkMemberMenu

;------------------------------------------check member menu input

checkMemberMenu:
cmp bl, 33h
jg member_menu_error_message

cmp bl, 33h
je exit                      

jmp registerMemberMenu

;-----------------------------------------display register member menu, prompt and read option

registerMemberMenu:
mov ah, 00
mov al, 02
int 10h

print display_register_membership_menu
print member_option

mov ah, 01h
int 21h 

mov bl, al

cmp bl, 31h
jge checkRegisterMemberMenu

;--------------------------------------------check register member input

checkRegisterMemberMenu:
cmp bl, 34h
jg register_member_menu_error_message

cmp bl, 34h
je memberMenu

print prompt_enter_name
mov si, 0
jmp input_name

;--------------------------------------------display error message at member menu

member_menu_error_message:
print display_error_message

call pause

jmp memberMenu

;--------------------------------------------display error message at register member menu

register_member_menu_error_message:
print display_error_message

call pause

jmp registerMemberMenu

;-------------------------------------------input name

input_name:
mov ah, 01h
int 21h
cmp al, 13
je prompt_input_age
mov [si], al
inc si
jmp input_name

;---------------------------------------------prompt enter name

prompt_input_age:
print prompt_enter_age
mov si, 0
jmp input_age

;----------------------------------------------input age

input_age:
mov ah, 01h
int 21h
cmp al, 13
je exit 
mov [si], al
inc si
jmp input_age

;-------------------------------------------------

;----------------------------------------exit

exit:
mov ax, 4ch
int 21h

main endp

;system("pause")    
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
