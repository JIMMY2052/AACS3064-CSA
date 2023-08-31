.model small
.stack 100h
.data
print macro msg
    mov ah,09h
    lea dx,msg
    int 21h
endm
invalidMemberIdMsg db 10,13,"Invalid Member ID. Hint: Please ensure the first letter is CAPITAL LETTER.$"
memberProceedMsg db 10,13,"Do you want check membership (y) or back to asking membership (n) >$"
memberid_Arr db "B01,B02,S01,S03,S05,G02,G03,$"
newline db 10,13,"$"
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

.code
main proc
mov ax,@data
mov ds,ax
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
 jmp endingMembership
 Silver:
 mov MembershipLevel,'S'
 print SilverMsg
 jmp endingMembership 
 Gold:
 mov MembershipLevel,'G'
 print GoldMsg
 jmp endingMembership
checkMembership:        ; check member id whether it is valid
call ReadMembershipF        ;Read Input of membership   
call validateMemberF        ; Validate Membership Function
mov al,correctMemberId
cmp al,1
je correctMemberIdLabel
print invalidMemberIdMsg
print pressAnytoContinue
call pause
call cls
jmp MembershipProceedLabel

correctMemberIdLabel:       ;IF correct Member Id , assign corresponding letter to a variable and print out the membership level + discount rate
mov si,0
mov al,[input_member_Arr + si]
cmp al,'B'
je Bronze
cmp al,'S'
je Silver
cmp al,'G'
je Gold

endingMembership:

mov ah,4ch
int 21h

main endp
ReadMembershipF proc
    print ReadMemberIDMsg
    lea dx,member_Arr
    mov ah,0ah
    int 21h
    ret
ReadMembershipF endp
validateMemberF proc
    mov si,0
    mov di,0
   
    mov al,[input_member_Arr + si]

    mov cx,1
    ValidateFirstCharMemberId:              ;First char validation
    mov dl,[memberid_Arr + di]
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
    mov dl,[memberid_Arr + di]
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
    mov dl,[memberid_Arr + di]
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
grandTotalF proc
    ret
grandTotalF endp
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