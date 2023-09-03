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
pw_Msg db 10,13,"Password (x = exit): $"
id db "sportxpert$"
pw db "password$"
invalidMemberIdMsg db 10,13,"Invalid Member ID.$"
memberProceedMsg db 10,13,"Do you want check membership (y) or back to asking membership (n) > $"
memberid_Arr db "B01,B02,S01,S03,S05,G02,G03,G04,B03,$"
memberid_Arr2 db 30 dup ('$')
hasMembershipMsg db 10,13,"Do customer has a membership (y = yes , n = no): $"
invalidCharMsg db 10,13,"Please enter a valid character (y = yes , n = no).",'$'
pressAnytoContinue db 10,13,"Press any key to continue...$"
ReadMemberIDMsg db 10,13,10,13,"Enter Member ID : $"
correctMemberId db 0
RM db "RM$"
gotMembership db ?
MembershipRate dw ?
BronzeMsg db 10,13,"This customer is Bronze Membership.  Customer can enjoy 5% discount.$"
SilverMsg db 10,13,"This customer is Silver Membership.  Customer can enjoy 10% discount.$"
GoldMsg db 10,13,"This customer is Gold Membership.  Customer can enjoy 15% discount.$"
isDot dw 0
ErrorFound dw 0
InvalidAmountPaidMsg db 10,13,"Only Accept number (1~9) and dot (.) $"
InvalidAmountPaidMsg2 db 10,13,"Cannot left it blank !$"
AmountPaidCount dw ?
AmountPaidtemp dw ?
exceedDecimal db 0
ReenterAMount db 10,13,"Only accept 2 Decimal Places! Please re-enter again the amount.$"
whetherGotDecimal db ?
changeCannotBorrow dw 0
grandTotalMsg db "Grand Total                 = RM $"
SSTMsg db "(+) SST (10%)               = RM $"
DiscountAmount db "(-) Membership Discount $"
equalSign db " = RM $"
NetTotalToPay db "Net Total                   = RM $"
RoundedNettotalMsg db "Amount To Pay               = RM $"
EnterAmount db 10,13,"Enter Amount                = RM $"
insufficentMsg db 10,13,"Insufficient Amount Paid !$"
ChangesMsg db 10,13,"Changes                     = RM $"
RoundingUpMsg db " (Rounded Up)$"

AmountPaid dw ?
AmountPaidDecimal12 dw ?
changeWholeNum dw 0
changeDecimal12 dw 0

RoundedNetTotal dw 0
RoundedNetTotalDecimal12 dw 0


SST dw 10
tempDiscounted dw 0
grandTotal dw 165
grandTotalDecimal12 dw 85
grandTotalDecimal34 dw 0

NetTotal dw 0
NetTotalDecimal12 dw 0
NetTotalDecimal34 dw 0

SSTGrandTotal dw 0
SSTGrandTotalDecimal12 dw 0
SSTGrandTotalDecimal34 dw 0

grandTotalDiscounted dw 0
Decimal12Discounted dw 0
Decimal34Discounted dw 0

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

Paymentlogo db 10,13,"                _____                                 _   "
            db 10,13,"               |  __ \                               | |  "
            db 10,13,"               | |__) |_ _ _   _ _ __ ___   ___ _ __ | |_ "
            db 10,13,"               |  ___/ _` | | | | '_ ` _ \ / _ \ '_ \| __|"
            db 10,13,"               | |  | (_| | |_| | | | | | |  __/ | | | |_ "
            db 10,13,"               |_|   \__,_|\__, |_| |_| |_|\___|_| |_|\__|"
            db 10,13,"                            __/ |                         "
            db 10,13,"                           |___/                          ",10,13,'$'              
headline db 10,13,"=========================================================================$"
processingPaymentMsg db "                                   Payment Processing... $"
idArr LABEL BYTE 
MAX DB 30 
ACT DB ? 
input_idArr DB 30 DUP ('$') 

pwArr LABEL BYTE 
MAX_pwArr DB 30 
ACT_pwArr DB ? 
input_pwArr DB 30 DUP ('$')

PaidAmount label byte
    max_PaidAmount db 10
    act_PaidAmount db ?
    PaidAmount_Arr db 10 dup('$')
.code
main proc
mov ax,@data
mov ds,ax

call cls
call login
call paymentFUNCTION
printAllAmountAgain2:
mov ErrorFound,0
call printingPayment
call CalculateChangeFUNCTION
mov ax,ErrorFound
cmp ax,1
jge printAllAmountAgain2
print ChangesMsg
call printChanges

mov ah,4ch
int 21h
main endp
printChanges proc
call clear
mov ax,changeWholeNum
call converter
mov ah,02h
mov dl,'.'
int 21h
mov ax,changeDecimal12
cmp ax,10
jl printchangeDecimal12For0
lp888:
call clear
mov ax,changeDecimal12
call converter
jmp endPrintChanges

printchangeDecimal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp888
endPrintChanges:
ret
printChanges endp
printingPayment proc
printAllAmountAgain:
call printoutAllAmount
mov AmountPaid,0
mov AmountPaidDecimal12,0
mov ErrorFound,0
mov isDot,0
call askingAmountPaidFUNCTION
mov ax,ErrorFound
cmp ax,1
jge printAllAmountAgain
ret
printingPayment endp
RoundUpFUNCTION proc
mov ax,NetTotal
mov RoundedNetTotal,ax
mov ax,NetTotalDecimal12
mov RoundedNetTotalDecimal12,ax
mov ax,NetTotalDecimal34
cmp ax,50
jge roundingUp
jmp endingRoundUP
roundingUp:
inc RoundedNetTotalDecimal12
endingRoundUP:
ret
RoundUpFUNCTION endp
CalculateChangeFUNCTION proc
mov ErrorFound,0
mov changeCannotBorrow,0
mov ax,AmountPaid
cmp ax,RoundedNetTotal
jl insufficientChange
cmp ax,RoundedNetTotal
je equalWholeNum
backToChangeCalculation:
sub ax,RoundedNetTotal
mov changeWholeNum,ax
mov ax,AmountPaidDecimal12
cmp ax,RoundedNetTotalDecimal12
jl changeBorrow12
backChangeBorrow12:
sub ax,RoundedNetTotalDecimal12
mov changeDecimal12,ax
jmp endingCalculateChange

changeBorrow12:
mov ax,changeCannotBorrow
cmp al,1
je insufficientChange
dec changeWholeNum
add ax,100
jmp backChangeBorrow12

insufficientChange:
inc ErrorFound
print insufficentMsg
print pressAnytoContinue
call pause
jmp endingCalculateChange

equalWholeNum:
inc changeCannotBorrow
jmp backToChangeCalculation

endingCalculateChange:
ret
CalculateChangeFUNCTION endp
askingAmountPaidFUNCTION proc

print EnterAmount
lea dx,PaidAmount                  ;Load the AmountPaid array address to capture string input11111
mov ah,0ah
int 21h

call validationAmoundPaid
call whetherAmoundPaidIsNum
mov ax,ErrorFound
cmp ax,1
jge endingAskingAmountPaid
call readAmountWhetherGotDecimal      ;Function that read the AmountPaid and array length11111111
mov al,whetherGotDecimal
cmp al,'n'
je AmountNoDecimal
AmountGotDecimalLabel:
call AmountGotDecimal                ;IF got floating point then run this111111111
mov ax,ErrorFound
cmp ax,1
jge endingAskingAmountPaid
jmp endingAskingAmountPaid 

AmountNoDecimal:                      ;IF no floating point then run this1111111111
call storingAmountPaidWholeNum
endingAskingAmountPaid:
ret
askingAmountPaidFUNCTION endp
validationAmoundPaid proc
mov si,0
mov al,[PaidAmount_Arr + si]
cmp al,'.'
je NotValidAmountPaid
cmp al,13
je NotValidAmountPaid
jmp endingValidationAmounPaid
NotValidAmountPaid:
inc ErrorFound
print InvalidAmountPaidMsg2
print pressAnytoContinue
call pause
endingValidationAmounPaid:
ret
validationAmoundPaid endp
whetherAmoundPaidIsNum proc
call clear
mov si,0
mov cx,1

validateTheStringWhetherisNum:
mov al,[PaidAmount_Arr + si]
cmp al,13
je ItisvalidStringNum
cmp al,'0'
jl mightHaveError
cmp al,'9'
jg mightHaveError
NotError:
inc cx
inc si
loop validateTheStringWhetherisNum

mightHaveError:
cmp al,'.'
jne isNotDotLabel
inc isDot
mov ax,isDot
cmp ax,1
jle  NotError
isNotDotLabel:
inc ErrorFound
print InvalidAmountPaidMsg
print pressAnytoContinue
call pause

ItisvalidStringNum:
ret
whetherAmoundPaidIsNum endp
storingAmountPaidWholeNum proc
call clear
mov si,0
calculationAmountPaid:
dec AmountPaidCount
mov cx,AmountPaidCount
xor ah,ah
mov al,[PaidAmount_Arr+si]     ;----multiply all the number in array into the whole number and store them into a AmountPaid variable
inc si
cmp AmountPaidCount,0
je addition
multiplication:
mov bx,10d
mul bx
loop multiplication
addition:
add AmountPaid,ax
cmp AmountPaidCount,0
jnz calculationAmountPaid
ret
storingAmountPaidWholeNum endp
AmountGotDecimal proc
call storingAmountPaidWholeNum
mov AmountPaidCount ,0
call clear
mov cx,1
inc AmountPaidtemp
mov si,AmountPaidtemp
mov exceedDecimal,0
Reading_AmoundPaidFloatingNumber:     ; --Reading digit Place and store back that converted character into array
mov al,exceedDecimal
cmp al,3
jge exceddDecimalLabel
mov al,[PaidAmount_Arr+si]
cmp al,13
je next2
sub al,30h
mov [PaidAmount_Arr+si],al
inc si
inc cx
inc exceedDecimal
inc AmountPaidCount
loop Reading_AmoundPaidFloatingNumber

exceddDecimalLabel:
print ReenterAMount
print pressAnytoContinue
call pause
inc ErrorFound
jmp endingstoringAmountWholeNum
next2:
call clear
mov si,AmountPaidtemp
calculationAmountPaidF:
dec AmountPaidCount
mov cx,AmountPaidCount
xor ah,ah
mov al,[PaidAmount_Arr+si]     ;----multiply all the number in array into the real number and store them into a new variable
inc si
cmp AmountPaidCount,0
je additionF
multiplicationF:
mov bx,10d
mul bx
loop multiplicationF
additionF:
add AmountPaidDecimal12,ax
cmp AmountPaidCount,0
jnz calculationAmountPaidF
endingstoringAmountWholeNum:
ret
AmountGotDecimal endp
readAmountWhetherGotDecimal proc
mov AmountPaidCount ,0
call clear
mov cx,1
mov si,0
Reading_priceWholeNumber:     ; this label is to read array length and subtract the 30hex  and store back the number into array FOR STORING THE DECIMAL NOT ASCII
mov al,[PaidAmount_Arr+si]
mov AmountPaidtemp,si
cmp al,'.'
je next1
cmp al,13
je AmountNoDecimalLabel
sub al,30h
mov [PaidAmount_Arr+si],al
inc si
inc cx
inc AmountPaidCount
loop Reading_priceWholeNumber
next1:
mov whetherGotDecimal,'y'
jmp endingReadAmountWhether
AmountNoDecimalLabel:
mov whetherGotDecimal,'n'
jmp endingReadAmountWhether
endingReadAmountWhether:
ret
readAmountWhetherGotDecimal endp
paymentFUNCTION proc
call hasMembership
mov al,gotMembership
cmp al,'n'
je SSTLabel
call MemberDiscountFuntion
jmp CalulateNetTotal
SSTLabel:
call clear
mov ax,grandTotal
mov NetTotal,ax
mov ax,grandTotalDecimal12
mov NetTotalDecimal12,ax
CalulateNetTotal:
call SSTFUNCTION
call NetTotalFUCTION
call RoundUpFUNCTION

ret
paymentFUNCTION endp
printRoundedTotal proc
call clear
mov ax,RoundedNetTotal
call converter
mov ah,02h
mov dl,'.'
int 21h
mov ax,RoundedNetTotalDecimal12
cmp ax,10
jl printRoundedNetTotalDecimal12For0
lp666:
call clear
mov ax,RoundedNetTotalDecimal12
call converter
jmp endPrintRoundedNetTotal

printRoundedNetTotalDecimal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp666
endPrintRoundedNetTotal:
ret
printRoundedTotal endp
printoutSSTFUNCTION proc
call clear
mov ax,SSTGrandTotal
call converter
mov ah,02h
mov dl,'.'
int 21h
mov ax,SSTGrandTotalDecimal12
cmp ax,10
jl printSSTGrandTotal12For0
lp333:
call clear
mov ax,SSTGrandTotalDecimal12
call converter
mov ax,SSTGrandTotalDecimal34
cmp ax,10
jl printSSTGrandTotal34For0
lp444:
call clear
mov ax,SSTGrandTotalDecimal34
call converter
jmp endPrintoutSSTGrandTotal
printSSTGrandTotal34For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp444

printSSTGrandTotal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp333
endPrintoutSSTGrandTotal:
ret
printoutSSTFUNCTION endp
printoutGrandTotalFUNCTION proc
call clear
mov ax,grandTotal
call converter
mov ah,02h
mov dl,'.'
int 21h
mov ax,grandTotalDecimal12
cmp ax,10
jl printGrandTotal12For0
lp33:
call clear
mov ax,grandTotalDecimal12
call converter
mov ax,grandTotalDecimal34
cmp ax,10
jl printGrandTotal34For0
lp44:
call clear
mov ax,grandTotalDecimal34
call converter
jmp endPrintoutGrandTotal
printGrandTotal34For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp44

printGrandTotal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp33
endPrintoutGrandTotal:
ret
printoutGrandTotalFUNCTION endp
printoutNetTotalFUNCTION proc
call clear
mov ax,NetTotal
call converter
mov ah,02h
mov dl,'.'
int 21h
mov ax,NetTotalDecimal12
cmp ax,10
jl printNetTotal12For0
lp3:
call clear
mov ax,NetTotalDecimal12
call converter
mov ax,NetTotalDecimal34
cmp ax,10
jl printNetTotal34For0
lp4:
call clear
mov ax,NetTotalDecimal34
call converter
jmp endPrintoutNetTotal
printNetTotal34For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp4

printNetTotal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp3
endPrintoutNetTotal:
ret
printoutNetTotalFUNCTION endp
NetTotalFUCTION proc
mov ax, NetTotal
add ax, SSTGrandTotal
mov NetTotal, ax
call clear
mov ax, NetTotalDecimal34
add ax, SSTGrandTotalDecimal34
cmp ax,100
jge carry34
mov NetTotalDecimal34,ax
call clear
lp1:
call clear
mov ax,NetTotalDecimal12
add ax,SSTGrandTotalDecimal12
cmp ax,100
jge carry12
mov NetTotalDecimal12,ax
lp2:
jmp endNetTotalFUNTION

carry12:
mov bx,100
div bx
mov NetTotalDecimal12,dx
add NetTotal,ax
jmp lp2

carry34:
mov bx,100
div bx
mov NetTotalDecimal34,dx
add NetTotalDecimal12,ax
jmp lp1
endNetTotalFUNTION:
ret
NetTotalFUCTION endp
MemberDiscountFuntion proc
;----------------------------------------------------
mov ax,grandTotal
mov NetTotal,ax
mov ax,grandTotalDecimal12
mov NetTotalDecimal12,ax
mov ax,NetTotal
mov bx,MembershipRate
mul bx
mov tempDiscounted,ax
call clear
mov ax,tempDiscounted
mov bx,100
div bx
mov grandTotalDiscounted,ax
mov Decimal12Discounted,dx
;----------------------------------------------------
mov ax,NetTotalDecimal12
mov NetTotalDecimal12,ax
mov bx,MembershipRate
mul bx
mov tempDiscounted,ax
call clear
mov ax,tempDiscounted
mov bx,100
div bx
add Decimal12Discounted,ax
mov Decimal34Discounted,dx
jmp nettotalSubtractDiscount
;----------------------------------------------------
NoBorrow12:
sub ax,Decimal12Discounted
mov NetTotalDecimal12,ax
jmp done_subtract

NoBorrow34:
sub bx,Decimal34Discounted
mov NetTotalDecimal34,bx
jmp subtract_the_decimal12

nettotalSubtractDiscount:
mov ax,NetTotal
sub ax,grandTotalDiscounted
mov NetTotal,ax
mov bx,NetTotalDecimal34
cmp bx,Decimal34Discounted
jge NoBorrow34
dec NetTotalDecimal12
add NetTotalDecimal34,100
mov bx,NetTotalDecimal34
sub bx,Decimal34Discounted
mov NetTotalDecimal34,bx

subtract_the_decimal12:
mov ax,NetTotalDecimal12
cmp ax,Decimal12Discounted
jge NoBorrow12
dec NetTotal
add NetTotalDecimal12,100
mov ax,NetTotalDecimal12
sub ax,Decimal12Discounted
mov NetTotalDecimal12,ax


done_subtract:
ret
MemberDiscountFuntion endp
SSTFUNCTION proc
    call clear
    mov ax,grandTotal
    mov bx,SST
    div bx
    mov SSTGrandTotal, ax
    mov ax,dx
    mov bx,10
    mul bx
    mov SSTGrandTotalDecimal12,ax

    mov ax,grandTotalDecimal12
    mov bx,10
    div bx
    add SSTGrandTotalDecimal12,ax
    mov SSTGrandTotalDecimal34,dx
    mov ax,SSTGrandTotalDecimal34
    mov bx,10
    mul bx
    mov SSTGrandTotalDecimal34,ax
ret
SSTFUNCTION endp
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
je endinghasMembership
cmp al,'n'                      ;No membership then directly go to grandtotal calculation
je endinghasMembership
print invalidCharMsg
print pressAnytoContinue
call pause
call cls
jmp paymentLabel
endinghasMembership:
mov gotMembership,al
jmp exitMembership
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
Bronze:
 mov MembershipRate,5
print BronzeMsg
print pressAnytoContinue
call pause
 jmp exitMembership
 Silver:
 mov MembershipRate,10
 print SilverMsg
print pressAnytoContinue
call pause
 jmp exitMembership
 Gold:
 mov MembershipRate,15
 print GoldMsg
 print pressAnytoContinue
call pause
 jmp exitMembership
exitMembership:
ret
hasMembership endp
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
printoutDiscountedTotalFUNCTION proc
    call clear
    mov ax,grandTotalDiscounted
    call converter
    mov ah,02h
    mov dl,'.'
    int 21h
    call clear
    mov ax,Decimal12Discounted
    cmp ax,10
    jl printing12For0
    backPrinting12:
    call clear
    mov ax,Decimal12Discounted
    call converter
    mov ax,Decimal34Discounted
    cmp ax,10
    jl printing34For0
    backPrinting34:
    call clear
    mov ax,Decimal34Discounted
    call converter
    jmp endprintoutDiscount
    printing34For0:
    mov ah,02h
    mov dl,'0'
    int 21h
    jmp backPrinting34
    
    printing12For0:
    mov ah,02h
    mov dl,'0'
    int 21h
    jmp backPrinting12
    endprintoutDiscount:
ret
printoutDiscountedTotalFUNCTION endp
printoutAllAmount proc
    call cls
    print Paymentlogo
    print headline 
    print processingPaymentMsg
    print headline
    print newline
    print grandTotalMsg
    call printoutGrandTotalFUNCTION
    print newline
    print SSTMsg
    call printoutSSTFUNCTION
    mov al,gotMembership
    cmp al,'n'
    je skipDisplayDiscountAmount
    print newline
    print DiscountAmount
    mov ax,MembershipRate
    call converter
    mov dl,'%'
    mov ah,02h
    int 21h
    mov ax,MembershipRate
    cmp al,5
    je printSpace
    backToprintingEqual:
    print equalSign
    call printoutDiscountedTotalFUNCTION
    skipDisplayDiscountAmount:
    print newline
    print NetTotalToPay
    call printoutNetTotalFUNCTION
    print headline
    print newline
    print RoundedNettotalMsg
    call printRoundedTotal
    print RoundingUpMsg
    jmp endingprintAllAmount
    printSpace:
    mov dl,32
    mov ah,02h
    int 21h
    jmp backToprintingEqual
    endingprintAllAmount:
    ret
printoutAllAmount endp
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
converter proc
  mov     bx,10d    
    xor     cx,cx          
a: xor     dx,dx          
    div     bx             
    push    dx             
    inc     cx             
    test    ax,ax          
    jnz     a             
    
b:  pop     dx             
    mov     ah,02h         
    add     dl,30h      
    int     21h            
    loop    b 
ret
converter endp
resetAllTheTotal proc
mov grandTotal,0
mov grandTotalDecimal12,0
mov grandTotalDecimal34,0

mov NetTotal,0
mov NetTotalDecimal12,0
mov NetTotalDecimal34,0

mov SSTGrandTotal,0
mov SSTGrandTotalDecimal12,0
mov SSTGrandTotalDecimal34,0

mov grandTotalDiscounted,0
mov Decimal12Discounted,0
mov Decimal34Discounted,0
ret
resetAllTheTotal endp
end main


