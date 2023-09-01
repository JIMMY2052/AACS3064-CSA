.model small
.stack 100h
.data
PRINT macro msg
    mov ah,09h
    lea dx,msg
    int 21h
    endm
newline db 10,13,"$"
false_login db 0
countLetter dw 0
logoutMsg db 10,13,10,13,10,13,"                    You have successfully logged out."
          db 10,13,"                    Thank you for using the system!",'$'
success_loginMsg db 10,13,"You have successful login!$"
invalid_ID_password_Msg db 10,13,"You have entered invalid user id or password.",10,13,"Press any key to continue...$"
userId_Msg db 10,13,"Username (x = exit): $"
pw_Msg db 10,13,"Password (x =  exit): $"
id db "sportxpert$"
pw db "password$"
invalidMemberIdMsg db 10,13,"Invalid Member ID."
memberProceedMsg db 10,13,"Do you want check membership (y) or back to asking membership (n) > $"
memberid_Arr db "B01,B02,S01,S03,S05,G02,G03,G04,B03,$"
memberid_Arr2 db 30 dup ('$')
hasMembershipMsg db 10,13,"Do customer has a membership (y OR n): $"
invalidCharMsg db 10,13,"Please enter a valid character (y OR n).",'$'
pressAnytoContinue db 10,13,"Press any key to continue...$"
ReadMemberIDMsg db 10,13,10,13,"Enter Member ID : $"
correctMemberId db 0
MembershipLevel db ?
BronzeMsg db 10,13,"This customer is Bronze Membership.  Customer can enjoy 5% discount.$"
SilverMsg db 10,13,"This customer is Silver Membership.  Customer can enjoy 10% discount.$"
GoldMsg db 10,13,"This customer is Gold Membership.  Customer can enjoy 15% discount.$"

member_Arr LABEL BYTE 
MAXmember_Arr DB 5
ACTmember_Arr DB ? 
input_member_Arr DB 5 DUP ('$')
logo db 10,13,"               _____                  _  __   __                _ "  
     db 10,13,"              / ____|                | | \ \ / /               | |"  
     db 10,13,"             | (___  _ __   ___  _ __| |_ \ V / _ __   ___ _ __| |_"
     db 10,13,"              \___ \| '_ \ / _ \| '__| __| > < | '_ \ / _ \ '__| __|"
     db 10,13,"              ____) | |_) | (_) | |  | |_ / . \| |_) |  __/ |  | |_ "
     db 10,13,"             |_____/| .__/ \___/|_|   \__/_/ \_\ .__/ \___|_|   \__|"
     db 10,13,"                    | |                        | |"                  
     db 10,13,"                    |_|                        |_|",10,13,'$'                 

idArr LABEL BYTE 
MAX DB 30 
ACT DB ? 
input_idArr DB 30 DUP ('$') 

pwArr LABEL BYTE 
MAX_pwArr DB 30 
ACT_pwArr DB ? 
input_pwArr DB 30 DUP ('$')
.code
main proc
mov ax,@data
mov ds,ax

call cls
call login
call hasMembership

mov ah,4ch
int 21h
main endp
grandTotalF proc
    ret
grandTotalF endp
ReadMembershipF proc
    print ReadMemberIDMsg
    lea dx,member_Arr
    mov ah,0ah
    int 21h
    ret
ReadMembershipF endp
validateMemberF proc
;---------sorting array into new array for validation------------------
mov di,0
mov si,0
mov cx,1
sorting1:
mov al,[memberid_Arr + si]
cmp al,'$'
je endforsorting
cmp al,[input_member_Arr]
je sorting
inc si
inc cx
loop sorting1

sorting:
mov [memberid_Arr2 + di], al
inc si
inc di
mov al,[memberid_Arr + si]
mov [memberid_Arr2 + di], al
inc si
inc di
mov al,[memberid_Arr + si]
mov [memberid_Arr2 + di], al
inc si
inc di
mov al,[memberid_Arr + si]
mov [memberid_Arr2 + di], al
inc si
inc di
jmp sorting1
;---------sorting array into new array for validation------------------
endforsorting:
    mov si,0
    mov di,0
   
    mov al,[input_member_Arr + si]
    

    mov cx,1
    ValidateFirstCharMemberId:              ;First char validation
    mov dl,[memberid_Arr2 + di]
    cmp dl,'$'
    je incorrectCharMemberId
    cmp al,dl
    je correctFirstCharMemberId
    add di,4
    inc cx
    loop ValidateFirstCharMemberId
;--------------------------------------------------------------------------------------------------------
    correctFirstCharMemberId:               ;IF correct first char then validate second char
    call clear
    mov si,1
    mov di,1
   
    mov al,[input_member_Arr + si]

    mov cx,1
    ValidateSecondCharMemberId:              ;Second char validation
    mov dl,[memberid_Arr2 + di]
    cmp dl,'$'
    je incorrectCharMemberId
    cmp al,dl
    je correctSecondCharMemberId
    add di,4
    inc cx
    loop ValidateSecondCharMemberId
;--------------------------------------------------------------------------------------------------------
    correctSecondCharMemberId:               ;IF correct second char then validate third char
    call clear
    mov si,2
    mov di,2
   
    mov al,[input_member_Arr + si]

    mov cx,1
    ValidateThirdCharMemberId:              ;Third char validation
    mov dl,[memberid_Arr2 + di]
    cmp dl,'$'
    je incorrectCharMemberId
    cmp al,dl
    je correctThirdCharMemberId
    add di,4
    inc cx
    loop ValidateThirdCharMemberId
  ;--------------------------------------------------------------------------------------------------------
    incorrectCharMemberId:
    mov correctMemberId,0
    jmp endingvalidateMemberF
    correctThirdCharMemberId:
    inc correctMemberId
    endingvalidateMemberF:
    ret
validateMemberF endp
hasMembership proc
;---------------------------------------------------------------------------------------------------
paymentLabel:           ;asking has Membership?
call cls
print hasMembershipMsg
mov ah,01h
int 21h

cmp al,'y'
je MembershipProceedLabel       
cmp al,'Y'                      ;jump to ask do you want to proceed membership checking
je MembershipProceedLabel
cmp al,'N'
je grandTotalLabel
cmp al,'n'                      ;No membership then directly go to grandtotal calculation
je grandTotalLabel
print invalidCharMsg
print pressAnytoContinue
call pause
call cls
jmp paymentLabel

grandTotalLabel:
call grandTotalF
;--------------------------------------------------------------------------------------------------

MembershipProceedLabel:         ; check whether want to proceed or back to previous step
print memberProceedMsg
mov ah,01h
int 21h
cmp al,'y'
je checkMembership
cmp al,'Y'
je checkMembership
cmp al,'N'
je paymentLabel                   ; back to asking membership step
cmp al,'n'
je paymentLabel
print invalidCharMsg
print pressAnytoContinue
call pause
call cls
jmp MembershipProceedLabel  

;--------------------------------------------------------------------------------------------------
Bronze:
 mov MembershipLevel,'B'
print BronzeMsg
 jmp endinghasMembership
 Silver:
 mov MembershipLevel,'S'
 print SilverMsg
 jmp endinghasMembership 
 Gold:
 mov MembershipLevel,'G'
 print GoldMsg
 jmp endinghasMembership
checkMembership:        ; check member id whether it is valid
call ReadMembershipF     ;Read Input of membership       
call validateMemberF      ; Validate Membership Function

mov al,correctMemberId
cmp al,1
je correctMemberIdLabel
print invalidMemberIdMsg
print pressAnytoContinue
call pause
call cls
jmp MembershipProceedLabel

correctMemberIdLabel:           ;IF correct Member Id , assign corresponding letter to a variable and print out the membership level + discount rate
mov si,0
mov al,[input_member_Arr + si]
cmp al,'B'
je Bronze
cmp al,'S'
je Silver
cmp al,'G'
je Gold

endinghasMembership:
ret
hasMembership endp
login proc
    username:
    print logo
    mov countLetter,0
    mov false_login,0

    PRINT userId_Msg

    lea dx,idArr
    mov ah,0ah
    int 21h

    
    mov si,0
    mov cx,1
    mov bl,[input_idArr+si]
    cmp bl,'x'                  ; jump to End Program IF "x"
    je logout1
    p1:
    mov bl,[input_idArr+si]
    cmp bl,13
    je idclear
    inc countLetter
    inc si
    inc cx
    loop p1

    logout1:
    print logoutMsg
    mov ah,4ch
    int 21h

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
    mov bl,[input_pwArr+si]
    cmp bl,'x'                  ; jump to End Program IF "x"
    je logout2
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

    logout2:
    print logoutMsg
    mov ah,4ch
    int 21h
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
    print pressAnytoContinue
    call pause
    
    ret
login endp
clear PROC          ;clear FUNCTION
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor dx,dx
    ret
clear endp
CLS proc            ;clear screen FUNCTION
    mov ah, 00 
    mov al, 02
    int 10h
    ret 
CLS endp
pause proc          ;pause FUNCTION
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


