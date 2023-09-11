.model small
.stack 100
.data
 print macro sout
    mov ah, 09h
    lea dx, sout
    int 21h
 endm 
 
newline db 10, 13, '$'

memberMenu db 10, 13, "          ----------------------------------------"
           db 10, 13, "          |             Member Menu              |"
           db 10, 13, "          ----------------------------------------"
           db 10, 13, "          |                                      |"
           db 10, 13, "          |        1. Register Membership        |"
           db 10, 13, "          |        2. Display Member             |"
           db 10, 13, "          |        3. Exit                       |"
           db 10, 13, "          |                                      |"
           db 10, 13, "          ----------------------------------------$"
           
registerMbrMenu db 10, 13, "          ------------------------------------------------------"
                db 10, 13, "          |                 Register Membership                |"
                db 10, 13, "          ------------------------------------------------------"
                db 10, 13, "          |                                                    |"
                db 10, 13, "          |         1. Bronze Membership (5% discount)         |"
                db 10, 13, "          |         2. Silver Membership (10% discount)        |"
                db 10, 13, "          |         3. Gold Membership (15% discount)          |"
                db 10, 13, "          |         4. Exit                                    |"
                db 10, 13, "          |                                                    |"
                db 10, 13, "          ------------------------------------------------------$"
                   
bronzeMenu db 10, 13, "          --------------------------------------------------------"
           db 10, 13, "          |                                                      |"
           db 10, 13, "          |        Bronze Member (e.g. B01) (5% discount)        |"
           db 10, 13, "          |                                                      |"
           db 10, 13, "          --------------------------------------------------------", 10, 13, "$"
                  
silverMenu db 10, 13, "          ---------------------------------------------------------"
           db 10, 13, "          |                                                       |"
           db 10, 13, "          |        Silver Member (e.g. S01) (10% discount)        |"
           db 10, 13, "          |                                                       |"
           db 10, 13, "          ---------------------------------------------------------", 10, 13, "$"
                  
goldMenu db 10, 13, "          ------------------------------------------------------"
         db 10, 13, "          |                                                    |"
         db 10, 13, "          |       Gold Member (e.g. G01) (15% discount)        |"
         db 10, 13, "          |                                                    |"
         db 10, 13, "          ------------------------------------------------------", 10, 13, "$"
                                                                               
memberList db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |                  Member                   |"
           db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |  Member Id  |  MemberName  |  Member Age  |"
           db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |             |              |              |$"
 
memberListEnd db 10, 13, "          |             |              |              |"
              db 10, 13, "          ---------------------------------------------$"
         
mbrOpt db 10, 13, "Enter an option: $"

mbrName label byte
mbrNameMax db 50
nameAct db ?
mbrNameArray db 50 dup("$")
;mbrNameCount db 0

mbrAge label byte
mbrAgeMax db 50
ageAct db ?
mbrAgeArray db 50 dup("$")
;mbrAgeCount db 0

mbrIdCharacterArray db 60 dup('$');    <-------------------array at here

mbrOptErrorMsg db 10, 13, "Please input a effective number!$"
nameErrorMsg db 10, 13, "Please input your username exactly 10 characters!$"
emptyNameErrorMsg db 10, 13, "Please input a username!$"
ageErrorMsg db 10, 13, "Your input is not valid in age to register member!$"
emptyAgeErrorMsg db 10, 13, "Please input your age!$"
confirmationErrorMsg db 10, 13, "Please input a valid character!$"

enterMbrName db 10, 13, "Enter your username in 10 characters (x = eixt): $"
enterMbrAge db 10, 13, "Enter your age (x = eixt) (18 - 99): $"
displayMbrId db 10, 13, "This is your member id: $"
addMbrConfirmation db 10, 13, "Confirm to add member (Y/y = yes) (N/n = no)? $"
addMbrSuccessful db 10, 13, "Your member have added successfully"
continue db 10, 13, "Press any key to continue...$"

tempMbrType db 0 
mbrIdCount dw 0
tempMbrId db 4 dup('$')

bronze1 db "B01$"
bronze2 db "B02$"
bronze3 db "B03$"
bronze4 db "B04$"
bronze5 db "B05$"
bronzeStringArray dw 5 dup("$")
bronzeStringArrayCount dw 0
bronzeCount db 1
bronzeNameArray db 55 dup('$')
bronzeNameCount dw 0
bronzeAgeArray db 15 dup('$')
bronzeAgeCount dw 0
 
silver1 db "S01$"
silver2 db "S02$"
silver3 db "S03$"
silver4 db "S04$"
silver5 db "S05$"
silverStringArray dw 5 dup("$")
silverStringArrayCount dw 0
silverCount db 1         
silverNameArray db 55 dup('$')
silverNameCount dw 0
silverAgeArray db 15 dup('$')
silverAgeCount dw 0
 
gold1 db "G01$"
gold2 db "G02$"
gold3 db "G03$"
gold4 db "G04$"
gold5 db "G05$"
goldStringArray dw 5 dup("$")
goldStringArrayCount dw 0
goldCount db 1
goldNameArray db 55 dup('$')
goldNameCount dw 0
goldAgeArray db 15 dup('$')
goldAgeCount dw 0 

displayOrder db 0
nameListCount db 0

beforeId dw 10, 13, "         |  $"
afterId dw "        |  $" 
afterName dw "  |  $"
afterAge dw "          |$"
bronzeIdLoop dw 0
silverIdLoop dw 0
goldIdLoop dw 0 

bronzeNameLoop dw 0
silverNameLoop dw 0
goldNameLoop dw 0 

bronzeAgeLoop dw 0
silverAgeLoop dw 0
goldAgeLoop dw 0

.code
main proc
    mov ax, @data
    mov ds, ax
    
    call LoadArray
    call Member
    
    main endp

loadArray proc
    mov si, 0
    lea bx, bronze1
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze2
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze3
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze4
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze5
    mov bronzeStringArray[si], bx
    
    mov si, 0
    lea bx, silver1
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver2
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver3
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver4
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver5
    mov silverStringArray[si], bx
    
    mov si, 0
    lea bx, gold1
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold2
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold3
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold4
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold5
    mov goldStringArray[si], bx
    
    ret
    LoadArray endp

Member proc
    call ClearScreen
    print memberMenu
    print mbrOpt
    
    mov ah, 01h
    int 21h
    cmp al, 31h
    je RegisterMember
    cmp al, 32h
    je DisplayMember
    cmp al, 33h
    je Exit
    
    call MemberErrorMessage
    
    ret
    Member endp
    
MemberErrorMessage proc
    print mbrOptErrorMsg
    call Pause 
    call Member
    
    ret
    MemberErrorMessage endp

RegisterMember proc
    call ClearScreen
    print registerMbrMenu
    print mbrOpt
    
    mov ah, 01h
    int 21h
    mov tempMbrType, al   ;<----- store either 1, 2 or 3 for member id auto generate according with the option selected
    cmp al, 31h
    je Bronze
    cmp al, 32h
    je Silver
    cmp al, 33h
    je Gold
    cmp al, 34h
    je Member
    
    call RegisterMemberErrorMessage
    
    ret
    RegisterMember endp

RegisterMemberErrorMessage proc
    print newline
    print mbrOptErrorMsg
    call Pause 
    call RegisterMember
    
    ret
    RegisterMemberErrorMessage endp

Bronze proc
    call ClearScreen
    print bronzeMenu
    
    call MemberName
    
    ret
    Bronze endp

Silver proc
    call ClearScreen
    print silverMenu
    
    call MemberName
    
    ret
    Silver endp

Gold proc
    call ClearScreen
    print goldMenu
    
    call MemberName
    
    ret
    Gold endp

MemberName proc
    print newline
    print enterMbrName
    
    mov ah, 0ah
    lea dx, mbrName
    int 21h
    
    cmp nameAct, 0
    je EmptyNameErrorMessage
    cmp nameAct, 1
    je NameCheckX
    cmp nameAct, 10
    je MemberAge
    
    call NameErrorMessage
    
    ret
    MemberName endp

NameErrorMessage proc
    print nameErrorMsg
    call Pause        
    
    cmp tempMbrType, 31h
    je Bronze
    cmp tempMbrType, 32h
    je Silver
    cmp tempMbrType, 33h
    je Gold
    
    ret
    NameErrorMessage endp

EmptyNameErrorMessage proc
    print emptyNameErrorMsg
    call Pause
    
    cmp tempMbrType, 31h
    je Bronze
    cmp tempMbrType, 32h
    je Silver
    cmp tempMbrType, 33h
    je Gold
    
    ret
    EmptyNameErrorMessage endp

NameCheckX proc
    mov si, 0
    cmp mbrNameArray[si], 'X'
    je RegisterMember
    cmp mbrNameArray[si], 'x'
    je RegisterMember
    
    call NameErrorMessage
    
    ret
    NameCheckX endp

MemberAge proc
    print enterMbrAge
    
    mov ah, 0ah
    lea dx, mbrAge
    int 21h
    
    cmp ageAct, 0
    je EmptyAgeErrorMessage
    cmp ageAct, 1
    je AgeCheckX
    cmp ageAct, 2
    je CheckAge
    
    call AgeErrorMessage
    
    ret
    MemberAge endp

AgeErrorMessage proc
    print ageErrorMsg
    call pause
    call MemberAge
    
    ret
    AgeErrorMessage endp

EmptyAgeErrorMessage proc
    print emptyAgeErrorMsg
    call pause
    call MemberAge
    
    ret
    EmptyAgeErrorMessage endp

AgeCheckX proc
    mov si, 0
    cmp mbrAgeArray[si], 'X'
    je RegisterMember
    cmp mbrAgeArray[si], 'x'
    je RegisterMember
    
    call AgeErrorMessage
    
    ret
    AgeCheckX endp

CheckAge proc
    mov si, 0
    cmp mbrAgeArray[si], 30h
    jle AgeErrorMessage
    cmp mbrAgeArray[si], 31h
    je Check8and9
    cmp mbrAgeArray[si], 39h
    jg AgeErrorMessage
    inc si
    cmp mbrAgeArray[si], 30h
    jl AgeErrorMessage
    cmp mbrAgeArray[si], 39h
    jg AgeErrorMessage
    
    call FindMemberId
    
    ret
    CheckAge endp

Check8and9 proc
    mov di, 1
    cmp mbrAgeArray[di], 38h
    je ConfirmAddMember
    cmp mbrAgeArray[di], 39h
    je ConfirmAddMember
    
    call AgeErrorMessage
    
    ret
    Check8and9 endp

FindMemberId proc        
    cmp tempMbrType, 31h
    je DisplayBronze
    cmp tempMbrType, 32h
    je DisplaySilver
    cmp tempMbrType, 33h
    je DisplayGold
    
    ret
    FindMemberId endp

DisplayBronze proc
    print displayMbrId
    mov si, bronzeStringArrayCount    
    mov ah, 09h
    mov dx, bronzeStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplayBronze endp

DisplaySilver proc
    print displayMbrId
    mov si, silverStringArrayCount    
    mov ah, 09h
    mov dx, silverStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplaySilver endp

DisplayGold proc
    print displayMbrId
    mov si, goldStringArrayCount    
    mov ah, 09h
    mov dx, goldStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplayGold endp

ConfirmAddMember proc
    print newline
    print addMbrConfirmation
    
    mov ah, 01h
    int 21h
    
    cmp al, 'y'
    je StoreMember
    cmp al, 'Y'
    je StoreMember
    cmp al, 'n'
    je RegisterMember
    cmp al, 'N'
    je RegisterMember
    
    call AddMemberErrorMessage
    
    ret
    ConfirmAddMember endp

StoreMember proc
    cmp tempMbrType, 31h
    je StoreBronze
    cmp tempMbrType, 32h
    je StoreSilver
    cmp tempMbrType, 33h
    je StoreGold 
    
    ret
    StoreMember endp

AddMemberErrorMessage proc
    print confirmationErrorMsg
    call Pause
    
    call ConfirmAddMember
    
    ret
    AddMemberErrorMessage endp

StoreBronze proc
    ;store member id
    mov si, mbrIdCount 
    mov al, 'B'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, bronzeCount
    add al, 30h
    mov mbrIdCharacterArray[si], al 
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc bronzeCount
    inc mbrIdCount
    add bronzeStringArrayCount, 2 
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, bronzeNameCount
    b1:
    mov al, mbrNameArray[si]
    mov bronzeNameArray[di], al
    inc si
    inc di
    inc bronzeNameCount
    loop b1
    
    mov al, ','
    mov bronzeNameArray[di], al
    inc bronzeNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, bronzeAgeCount
    b2:
    mov al, mbrAgeArray[si]
    mov bronzeAgeArray[di], al
    inc si
    inc di
    inc bronzeAgeCount
    loop b2
    
    mov al, ','
    mov bronzeAgeArray[di], al
    inc bronzeAgeCount
    
    print addMbrSuccessful
    call Pause
    
    call Member  
    
    ret
    StoreBronze endp

StoreSilver proc
    ;store member id
    mov si, mbrIdCount 
    mov al, 'S'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, silverCount
    add al, 30h
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc silverCount
    inc mbrIdCount
    add silverStringArrayCount, 2
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, silverNameCount
    s1:
    mov al, mbrNameArray[si]
    mov silverNameArray[di], al
    inc si
    inc di
    inc silverNameCount
    loop s1
    
    mov al, ','
    mov silverNameArray[di], al
    inc silverNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, silverAgeCount
    s2:
    mov al, mbrAgeArray[si]
    mov silverAgeArray[di], al
    inc si
    inc di
    inc silverAgeCount
    loop s2
    
    mov al, ','
    mov silverAgeArray[di], al
    inc silverAgeArray 
    
    print addMbrSuccessful
    call Pause
    
    call Member
    
    ret
    StoreSilver endp

StoreGold proc   
    ;store member id
    mov si, mbrIdCount 
    mov al, 'G'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, goldCount
    add al, 30h
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc goldCount
    inc mbrIdCount
    add goldStringArrayCount, 2
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, goldNameCount
    g1:
    mov al, mbrNameArray[si]
    mov goldNameArray[di], al
    inc si
    inc di
    inc goldNameCount
    loop g1
    
    mov al, ','
    mov goldNameArray[di], al
    inc goldNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, goldAgeCount
    g2:
    mov al, mbrAgeArray[si]
    mov goldAgeArray[di], al
    inc si
    inc di
    inc goldAgeCount
    loop g2
    
    mov al, ','
    mov goldAgeArray[di], al
    inc goldAgeArray
    
    print addMbrSuccessful
    call Pause
    
    call Member 
    
    ret
    StoreGold endp

DisplayMember proc
    call ClearScreen
    print memberList
    
    call DisplayBronzeList
    
    ret
    DisplayMember endp

DisplayBronzeList proc 
    mov si, 0
    mov ax, bronzeStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov bronzeIdLoop ,ax
    
    bl1:
    mov ax,bronzeIdLoop
    cmp ax, 1
    je DisplaySilverList
    mov cx, ax
     
    print beforeId
    mov dx, bronzeStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, bronzeNameLoop
    mov cx, 10
    bl2:
    mov ah, 02h
    mov dl, bronzeNameArray[di]
    int 21h
    inc di
    inc bronzeNameLoop
    loop bl2
    
    inc bronzeNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, bronzeAgeLoop
    mov cx, 2
    bl3:
    mov ah, 02h
    mov dl, bronzeAgeArray[di]
    int 21h
    inc di
    inc bronzeAgeLoop
    loop bl3
    
    inc bronzeAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec bronzeIdLoop
    mov cx, bronzeIdLoop
    loop bl1
    
    mov bronzeNameLoop, 0
    mov bronzeAgeLoop, 0
    
    call DisplaySilverList  
    
    ret
    DisplayBronzeList endp

DisplaySilverList proc
    mov si, 0
    mov ax, silverStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov silverIdLoop ,ax
    
    sl1:
    mov ax,silverIdLoop
    cmp ax, 1
    je DisplayGoldList
    mov cx, ax
     
    print beforeId
    mov dx, silverStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, silverNameLoop
    mov cx, 10
    sl2:
    mov ah, 02h
    mov dl, silverNameArray[di]
    int 21h
    inc di
    inc silverNameLoop
    loop sl2
    
    inc silverNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, silverAgeLoop
    mov cx, 2
    sl3:
    mov ah, 02h
    mov dl, silverAgeArray[di]
    int 21h
    inc di
    inc silverAgeLoop
    loop sl3
    
    inc silverAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec silverIdLoop
    mov cx, silverIdLoop
    loop sl1
    
    mov silverNameLoop, 0
    mov silverAgeLoop, 0 
    
    call DisplayGoldList 
    
    ret
    DisplaySilverList endp

DisplayGoldList proc
    mov si, 0
    mov ax, goldStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov goldIdLoop ,ax
    
    gl1:
    mov ax,goldIdLoop
    cmp ax, 1
    je PressAnyToContinue
    mov cx, ax
     
    print beforeId
    mov dx, goldStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, goldNameLoop
    mov cx, 10
    gl2:
    mov ah, 02h
    mov dl, goldNameArray[di]
    int 21h
    inc di
    inc goldNameLoop
    loop gl2
    
    inc goldNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, goldAgeLoop
    mov cx, 2
    gl3:
    mov ah, 02h
    mov dl, goldAgeArray[di]
    int 21h
    inc di
    inc goldAgeLoop
    loop gl3
    
    inc goldAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec goldIdLoop
    mov cx, goldIdLoop
    loop gl1
    
    mov goldNameLoop, 0
    mov goldAgeLoop, 0   
    
    call PressAnyToContinue
    
    ret
    DisplayGoldList endp

PressAnyToContinue proc
    print memberListEnd
    print newline
    print continue
    call Pause
    
    call Member
    
    ret
    PressAnyToContinue endp

ClearScreen proc
    mov ah, 00
    mov al, 02
    int 10h
    ret
    ClearScreen endp

Pause proc

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
    Pause endp

Exit proc
    mov ax, 4c00h
    int 21h
    ret
    Exit endp
end main.model small
.stack 100
.data
 print macro sout
    mov ah, 09h
    lea dx, sout
    int 21h
 endm 
 
newline db 10, 13, '$'

memberMenu db 10, 13, "          ----------------------------------------"
           db 10, 13, "          |             Member Menu              |"
           db 10, 13, "          ----------------------------------------"
           db 10, 13, "          |                                      |"
           db 10, 13, "          |        1. Register Membership        |"
           db 10, 13, "          |        2. Display Member             |"
           db 10, 13, "          |        3. Exit                       |"
           db 10, 13, "          |                                      |"
           db 10, 13, "          ----------------------------------------$"
           
registerMbrMenu db 10, 13, "          ------------------------------------------------------"
                db 10, 13, "          |                 Register Membership                |"
                db 10, 13, "          ------------------------------------------------------"
                db 10, 13, "          |                                                    |"
                db 10, 13, "          |         1. Bronze Membership (5% discount)         |"
                db 10, 13, "          |         2. Silver Membership (10% discount)        |"
                db 10, 13, "          |         3. Gold Membership (15% discount)          |"
                db 10, 13, "          |         4. Exit                                    |"
                db 10, 13, "          |                                                    |"
                db 10, 13, "          ------------------------------------------------------$"
                   
bronzeMenu db 10, 13, "          --------------------------------------------------------"
           db 10, 13, "          |                                                      |"
           db 10, 13, "          |        Bronze Member (e.g. B01) (5% discount)        |"
           db 10, 13, "          |                                                      |"
           db 10, 13, "          --------------------------------------------------------", 10, 13, "$"
                  
silverMenu db 10, 13, "          ---------------------------------------------------------"
           db 10, 13, "          |                                                       |"
           db 10, 13, "          |        Silver Member (e.g. S01) (10% discount)        |"
           db 10, 13, "          |                                                       |"
           db 10, 13, "          ---------------------------------------------------------", 10, 13, "$"
                  
goldMenu db 10, 13, "          ------------------------------------------------------"
         db 10, 13, "          |                                                    |"
         db 10, 13, "          |       Gold Member (e.g. G01) (15% discount)        |"
         db 10, 13, "          |                                                    |"
         db 10, 13, "          ------------------------------------------------------", 10, 13, "$"
                                                                               
memberList db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |                  Member                   |"
           db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |  Member Id  |  MemberName  |  Member Age  |"
           db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |             |              |              |$"
 
memberListEnd db 10, 13, "          |             |              |              |"
              db 10, 13, "          ---------------------------------------------$"
         
mbrOpt db 10, 13, "Enter an option: $"

mbrName label byte
mbrNameMax db 50
nameAct db ?
mbrNameArray db 50 dup("$")
;mbrNameCount db 0

mbrAge label byte
mbrAgeMax db 50
ageAct db ?
mbrAgeArray db 50 dup("$")
;mbrAgeCount db 0

mbrIdCharacterArray db 60 dup('$');    <-------------------array at here

mbrOptErrorMsg db 10, 13, "Please input a effective number!$"
nameErrorMsg db 10, 13, "Please input your username exactly 10 characters!$"
emptyNameErrorMsg db 10, 13, "Please input a username!$"
ageErrorMsg db 10, 13, "Your input is not valid in age to register member!$"
emptyAgeErrorMsg db 10, 13, "Please input your age!$"
confirmationErrorMsg db 10, 13, "Please input a valid character!$"

enterMbrName db 10, 13, "Enter your username in 10 characters (x = eixt): $"
enterMbrAge db 10, 13, "Enter your age (x = eixt) (18 - 99): $"
displayMbrId db 10, 13, "This is your member id: $"
addMbrConfirmation db 10, 13, "Confirm to add member (Y/y = yes) (N/n = no)? $"
addMbrSuccessful db 10, 13, "Your member have added successfully"
continue db 10, 13, "Press any key to continue...$"

tempMbrType db 0 
mbrIdCount dw 0
tempMbrId db 4 dup('$')

bronze1 db "B01$"
bronze2 db "B02$"
bronze3 db "B03$"
bronze4 db "B04$"
bronze5 db "B05$"
bronzeStringArray dw 5 dup("$")
bronzeStringArrayCount dw 0
bronzeCount db 1
bronzeNameArray db 55 dup('$')
bronzeNameCount dw 0
bronzeAgeArray db 15 dup('$')
bronzeAgeCount dw 0
 
silver1 db "S01$"
silver2 db "S02$"
silver3 db "S03$"
silver4 db "S04$"
silver5 db "S05$"
silverStringArray dw 5 dup("$")
silverStringArrayCount dw 0
silverCount db 1         
silverNameArray db 55 dup('$')
silverNameCount dw 0
silverAgeArray db 15 dup('$')
silverAgeCount dw 0
 
gold1 db "G01$"
gold2 db "G02$"
gold3 db "G03$"
gold4 db "G04$"
gold5 db "G05$"
goldStringArray dw 5 dup("$")
goldStringArrayCount dw 0
goldCount db 1
goldNameArray db 55 dup('$')
goldNameCount dw 0
goldAgeArray db 15 dup('$')
goldAgeCount dw 0 

displayOrder db 0
nameListCount db 0

beforeId dw 10, 13, "         |  $"
afterId dw "        |  $" 
afterName dw "  |  $"
afterAge dw "          |$"
bronzeIdLoop dw 0
silverIdLoop dw 0
goldIdLoop dw 0 

bronzeNameLoop dw 0
silverNameLoop dw 0
goldNameLoop dw 0 

bronzeAgeLoop dw 0
silverAgeLoop dw 0
goldAgeLoop dw 0

.code
main proc
    mov ax, @data
    mov ds, ax
    
    call LoadArray
    call Member
    
    main endp

loadArray proc
    mov si, 0
    lea bx, bronze1
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze2
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze3
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze4
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze5
    mov bronzeStringArray[si], bx
    
    mov si, 0
    lea bx, silver1
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver2
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver3
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver4
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver5
    mov silverStringArray[si], bx
    
    mov si, 0
    lea bx, gold1
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold2
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold3
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold4
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold5
    mov goldStringArray[si], bx
    
    ret
    LoadArray endp

Member proc
    call ClearScreen
    print memberMenu
    print mbrOpt
    
    mov ah, 01h
    int 21h
    cmp al, 31h
    je RegisterMember
    cmp al, 32h
    je DisplayMember
    cmp al, 33h
    je Exit
    
    call MemberErrorMessage
    
    ret
    Member endp
    
MemberErrorMessage proc
    print mbrOptErrorMsg
    call Pause 
    call Member
    
    ret
    MemberErrorMessage endp

RegisterMember proc
    call ClearScreen
    print registerMbrMenu
    print mbrOpt
    
    mov ah, 01h
    int 21h
    mov tempMbrType, al   ;<----- store either 1, 2 or 3 for member id auto generate according with the option selected
    cmp al, 31h
    je Bronze
    cmp al, 32h
    je Silver
    cmp al, 33h
    je Gold
    cmp al, 34h
    je Member
    
    call RegisterMemberErrorMessage
    
    ret
    RegisterMember endp

RegisterMemberErrorMessage proc
    print newline
    print mbrOptErrorMsg
    call Pause 
    call RegisterMember
    
    ret
    RegisterMemberErrorMessage endp

Bronze proc
    call ClearScreen
    print bronzeMenu
    
    call MemberName
    
    ret
    Bronze endp

Silver proc
    call ClearScreen
    print silverMenu
    
    call MemberName
    
    ret
    Silver endp

Gold proc
    call ClearScreen
    print goldMenu
    
    call MemberName
    
    ret
    Gold endp

MemberName proc
    print newline
    print enterMbrName
    
    mov ah, 0ah
    lea dx, mbrName
    int 21h
    
    cmp nameAct, 0
    je EmptyNameErrorMessage
    cmp nameAct, 1
    je NameCheckX
    cmp nameAct, 10
    je MemberAge
    
    call NameErrorMessage
    
    ret
    MemberName endp

NameErrorMessage proc
    print nameErrorMsg
    call Pause        
    
    cmp tempMbrType, 31h
    je Bronze
    cmp tempMbrType, 32h
    je Silver
    cmp tempMbrType, 33h
    je Gold
    
    ret
    NameErrorMessage endp

EmptyNameErrorMessage proc
    print emptyNameErrorMsg
    call Pause
    
    cmp tempMbrType, 31h
    je Bronze
    cmp tempMbrType, 32h
    je Silver
    cmp tempMbrType, 33h
    je Gold
    
    ret
    EmptyNameErrorMessage endp

NameCheckX proc
    mov si, 0
    cmp mbrNameArray[si], 'X'
    je RegisterMember
    cmp mbrNameArray[si], 'x'
    je RegisterMember
    
    call NameErrorMessage
    
    ret
    NameCheckX endp

MemberAge proc
    print enterMbrAge
    
    mov ah, 0ah
    lea dx, mbrAge
    int 21h
    
    cmp ageAct, 0
    je EmptyAgeErrorMessage
    cmp ageAct, 1
    je AgeCheckX
    cmp ageAct, 2
    je CheckAge
    
    call AgeErrorMessage
    
    ret
    MemberAge endp

AgeErrorMessage proc
    print ageErrorMsg
    call pause
    call MemberAge
    
    ret
    AgeErrorMessage endp

EmptyAgeErrorMessage proc
    print emptyAgeErrorMsg
    call pause
    call MemberAge
    
    ret
    EmptyAgeErrorMessage endp

AgeCheckX proc
    mov si, 0
    cmp mbrAgeArray[si], 'X'
    je RegisterMember
    cmp mbrAgeArray[si], 'x'
    je RegisterMember
    
    call AgeErrorMessage
    
    ret
    AgeCheckX endp

CheckAge proc
    mov si, 0
    cmp mbrAgeArray[si], 30h
    jle AgeErrorMessage
    cmp mbrAgeArray[si], 31h
    je Check8and9
    cmp mbrAgeArray[si], 39h
    jg AgeErrorMessage
    inc si
    cmp mbrAgeArray[si], 30h
    jl AgeErrorMessage
    cmp mbrAgeArray[si], 39h
    jg AgeErrorMessage
    
    call FindMemberId
    
    ret
    CheckAge endp

Check8and9 proc
    mov di, 1
    cmp mbrAgeArray[di], 38h
    je ConfirmAddMember
    cmp mbrAgeArray[di], 39h
    je ConfirmAddMember
    
    call AgeErrorMessage
    
    ret
    Check8and9 endp

FindMemberId proc        
    cmp tempMbrType, 31h
    je DisplayBronze
    cmp tempMbrType, 32h
    je DisplaySilver
    cmp tempMbrType, 33h
    je DisplayGold
    
    ret
    FindMemberId endp

DisplayBronze proc
    print displayMbrId
    mov si, bronzeStringArrayCount    
    mov ah, 09h
    mov dx, bronzeStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplayBronze endp

DisplaySilver proc
    print displayMbrId
    mov si, silverStringArrayCount    
    mov ah, 09h
    mov dx, silverStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplaySilver endp

DisplayGold proc
    print displayMbrId
    mov si, goldStringArrayCount    
    mov ah, 09h
    mov dx, goldStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplayGold endp

ConfirmAddMember proc
    print newline
    print addMbrConfirmation
    
    mov ah, 01h
    int 21h
    
    cmp al, 'y'
    je StoreMember
    cmp al, 'Y'
    je StoreMember
    cmp al, 'n'
    je RegisterMember
    cmp al, 'N'
    je RegisterMember
    
    call AddMemberErrorMessage
    
    ret
    ConfirmAddMember endp

StoreMember proc
    cmp tempMbrType, 31h
    je StoreBronze
    cmp tempMbrType, 32h
    je StoreSilver
    cmp tempMbrType, 33h
    je StoreGold 
    
    ret
    StoreMember endp

AddMemberErrorMessage proc
    print confirmationErrorMsg
    call Pause
    
    call ConfirmAddMember
    
    ret
    AddMemberErrorMessage endp

StoreBronze proc
    ;store member id
    mov si, mbrIdCount 
    mov al, 'B'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, bronzeCount
    add al, 30h
    mov mbrIdCharacterArray[si], al 
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc bronzeCount
    inc mbrIdCount
    add bronzeStringArrayCount, 2 
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, bronzeNameCount
    b1:
    mov al, mbrNameArray[si]
    mov bronzeNameArray[di], al
    inc si
    inc di
    inc bronzeNameCount
    loop b1
    
    mov al, ','
    mov bronzeNameArray[di], al
    inc bronzeNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, bronzeAgeCount
    b2:
    mov al, mbrAgeArray[si]
    mov bronzeAgeArray[di], al
    inc si
    inc di
    inc bronzeAgeCount
    loop b2
    
    mov al, ','
    mov bronzeAgeArray[di], al
    inc bronzeAgeCount
    
    print addMbrSuccessful
    call Pause
    
    call Member  
    
    ret
    StoreBronze endp

StoreSilver proc
    ;store member id
    mov si, mbrIdCount 
    mov al, 'S'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, silverCount
    add al, 30h
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc silverCount
    inc mbrIdCount
    add silverStringArrayCount, 2
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, silverNameCount
    s1:
    mov al, mbrNameArray[si]
    mov silverNameArray[di], al
    inc si
    inc di
    inc silverNameCount
    loop s1
    
    mov al, ','
    mov silverNameArray[di], al
    inc silverNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, silverAgeCount
    s2:
    mov al, mbrAgeArray[si]
    mov silverAgeArray[di], al
    inc si
    inc di
    inc silverAgeCount
    loop s2
    
    mov al, ','
    mov silverAgeArray[di], al
    inc silverAgeArray 
    
    print addMbrSuccessful
    call Pause
    
    call Member
    
    ret
    StoreSilver endp

StoreGold proc   
    ;store member id
    mov si, mbrIdCount 
    mov al, 'G'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, goldCount
    add al, 30h
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc goldCount
    inc mbrIdCount
    add goldStringArrayCount, 2
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, goldNameCount
    g1:
    mov al, mbrNameArray[si]
    mov goldNameArray[di], al
    inc si
    inc di
    inc goldNameCount
    loop g1
    
    mov al, ','
    mov goldNameArray[di], al
    inc goldNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, goldAgeCount
    g2:
    mov al, mbrAgeArray[si]
    mov goldAgeArray[di], al
    inc si
    inc di
    inc goldAgeCount
    loop g2
    
    mov al, ','
    mov goldAgeArray[di], al
    inc goldAgeArray
    
    print addMbrSuccessful
    call Pause
    
    call Member 
    
    ret
    StoreGold endp

DisplayMember proc
    call ClearScreen
    print memberList
    
    call DisplayBronzeList
    
    ret
    DisplayMember endp

DisplayBronzeList proc 
    mov si, 0
    mov ax, bronzeStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov bronzeIdLoop ,ax
    
    bl1:
    mov ax,bronzeIdLoop
    cmp ax, 1
    je DisplaySilverList
    mov cx, ax
     
    print beforeId
    mov dx, bronzeStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, bronzeNameLoop
    mov cx, 10
    bl2:
    mov ah, 02h
    mov dl, bronzeNameArray[di]
    int 21h
    inc di
    inc bronzeNameLoop
    loop bl2
    
    inc bronzeNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, bronzeAgeLoop
    mov cx, 2
    bl3:
    mov ah, 02h
    mov dl, bronzeAgeArray[di]
    int 21h
    inc di
    inc bronzeAgeLoop
    loop bl3
    
    inc bronzeAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec bronzeIdLoop
    mov cx, bronzeIdLoop
    loop bl1
    
    mov bronzeNameLoop, 0
    mov bronzeAgeLoop, 0
    
    call DisplaySilverList  
    
    ret
    DisplayBronzeList endp

DisplaySilverList proc
    mov si, 0
    mov ax, silverStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov silverIdLoop ,ax
    
    sl1:
    mov ax,silverIdLoop
    cmp ax, 1
    je DisplayGoldList
    mov cx, ax
     
    print beforeId
    mov dx, silverStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, silverNameLoop
    mov cx, 10
    sl2:
    mov ah, 02h
    mov dl, silverNameArray[di]
    int 21h
    inc di
    inc silverNameLoop
    loop sl2
    
    inc silverNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, silverAgeLoop
    mov cx, 2
    sl3:
    mov ah, 02h
    mov dl, silverAgeArray[di]
    int 21h
    inc di
    inc silverAgeLoop
    loop sl3
    
    inc silverAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec silverIdLoop
    mov cx, silverIdLoop
    loop sl1
    
    mov silverNameLoop, 0
    mov silverAgeLoop, 0 
    
    call DisplayGoldList 
    
    ret
    DisplaySilverList endp

DisplayGoldList proc
    mov si, 0
    mov ax, goldStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov goldIdLoop ,ax
    
    gl1:
    mov ax,goldIdLoop
    cmp ax, 1
    je PressAnyToContinue
    mov cx, ax
     
    print beforeId
    mov dx, goldStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, goldNameLoop
    mov cx, 10
    gl2:
    mov ah, 02h
    mov dl, goldNameArray[di]
    int 21h
    inc di
    inc goldNameLoop
    loop gl2
    
    inc goldNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, goldAgeLoop
    mov cx, 2
    gl3:
    mov ah, 02h
    mov dl, goldAgeArray[di]
    int 21h
    inc di
    inc goldAgeLoop
    loop gl3
    
    inc goldAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec goldIdLoop
    mov cx, goldIdLoop
    loop gl1
    
    mov goldNameLoop, 0
    mov goldAgeLoop, 0   
    
    call PressAnyToContinue
    
    ret
    DisplayGoldList endp

PressAnyToContinue proc
    print memberListEnd
    print newline
    print continue
    call Pause
    
    call Member
    
    ret
    PressAnyToContinue endp

ClearScreen proc
    mov ah, 00
    mov al, 02
    int 10h
    ret
    ClearScreen endp

Pause proc

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
    Pause endp

Exit proc
    mov ax, 4c00h
    int 21h
    ret
    Exit endp
end main.model small
.stack 100
.data
 print macro sout
    mov ah, 09h
    lea dx, sout
    int 21h
 endm 
 
newline db 10, 13, '$'

memberMenu db 10, 13, "          ----------------------------------------"
           db 10, 13, "          |             Member Menu              |"
           db 10, 13, "          ----------------------------------------"
           db 10, 13, "          |                                      |"
           db 10, 13, "          |        1. Register Membership        |"
           db 10, 13, "          |        2. Display Member             |"
           db 10, 13, "          |        3. Exit                       |"
           db 10, 13, "          |                                      |"
           db 10, 13, "          ----------------------------------------$"
           
registerMbrMenu db 10, 13, "          ------------------------------------------------------"
                db 10, 13, "          |                 Register Membership                |"
                db 10, 13, "          ------------------------------------------------------"
                db 10, 13, "          |                                                    |"
                db 10, 13, "          |         1. Bronze Membership (5% discount)         |"
                db 10, 13, "          |         2. Silver Membership (10% discount)        |"
                db 10, 13, "          |         3. Gold Membership (15% discount)          |"
                db 10, 13, "          |         4. Exit                                    |"
                db 10, 13, "          |                                                    |"
                db 10, 13, "          ------------------------------------------------------$"
                   
bronzeMenu db 10, 13, "          --------------------------------------------------------"
           db 10, 13, "          |                                                      |"
           db 10, 13, "          |        Bronze Member (e.g. B01) (5% discount)        |"
           db 10, 13, "          |                                                      |"
           db 10, 13, "          --------------------------------------------------------", 10, 13, "$"
                  
silverMenu db 10, 13, "          ---------------------------------------------------------"
           db 10, 13, "          |                                                       |"
           db 10, 13, "          |        Silver Member (e.g. S01) (10% discount)        |"
           db 10, 13, "          |                                                       |"
           db 10, 13, "          ---------------------------------------------------------", 10, 13, "$"
                  
goldMenu db 10, 13, "          ------------------------------------------------------"
         db 10, 13, "          |                                                    |"
         db 10, 13, "          |       Gold Member (e.g. G01) (15% discount)        |"
         db 10, 13, "          |                                                    |"
         db 10, 13, "          ------------------------------------------------------", 10, 13, "$"
                                                                               
memberList db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |                  Member                   |"
           db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |  Member Id  |  MemberName  |  Member Age  |"
           db 10, 13, "          ---------------------------------------------"
           db 10, 13, "          |             |              |              |$"
 
memberListEnd db 10, 13, "          |             |              |              |"
              db 10, 13, "          ---------------------------------------------$"
         
mbrOpt db 10, 13, "Enter an option: $"

mbrName label byte
mbrNameMax db 50
nameAct db ?
mbrNameArray db 50 dup("$")
;mbrNameCount db 0

mbrAge label byte
mbrAgeMax db 50
ageAct db ?
mbrAgeArray db 50 dup("$")
;mbrAgeCount db 0

mbrIdCharacterArray db 60 dup('$');    <-------------------array at here

mbrOptErrorMsg db 10, 13, "Please input a effective number!$"
nameErrorMsg db 10, 13, "Please input your username exactly 10 characters!$"
emptyNameErrorMsg db 10, 13, "Please input a username!$"
ageErrorMsg db 10, 13, "Your input is not valid in age to register member!$"
emptyAgeErrorMsg db 10, 13, "Please input your age!$"
confirmationErrorMsg db 10, 13, "Please input a valid character!$"

enterMbrName db 10, 13, "Enter your username in 10 characters (x = eixt): $"
enterMbrAge db 10, 13, "Enter your age (x = eixt) (18 - 99): $"
displayMbrId db 10, 13, "This is your member id: $"
addMbrConfirmation db 10, 13, "Confirm to add member (Y/y = yes) (N/n = no)? $"
addMbrSuccessful db 10, 13, "Your member have added successfully"
continue db 10, 13, "Press any key to continue...$"

tempMbrType db 0 
mbrIdCount dw 0
tempMbrId db 4 dup('$')

bronze1 db "B01$"
bronze2 db "B02$"
bronze3 db "B03$"
bronze4 db "B04$"
bronze5 db "B05$"
bronzeStringArray dw 5 dup("$")
bronzeStringArrayCount dw 0
bronzeCount db 1
bronzeNameArray db 55 dup('$')
bronzeNameCount dw 0
bronzeAgeArray db 15 dup('$')
bronzeAgeCount dw 0
 
silver1 db "S01$"
silver2 db "S02$"
silver3 db "S03$"
silver4 db "S04$"
silver5 db "S05$"
silverStringArray dw 5 dup("$")
silverStringArrayCount dw 0
silverCount db 1         
silverNameArray db 55 dup('$')
silverNameCount dw 0
silverAgeArray db 15 dup('$')
silverAgeCount dw 0
 
gold1 db "G01$"
gold2 db "G02$"
gold3 db "G03$"
gold4 db "G04$"
gold5 db "G05$"
goldStringArray dw 5 dup("$")
goldStringArrayCount dw 0
goldCount db 1
goldNameArray db 55 dup('$')
goldNameCount dw 0
goldAgeArray db 15 dup('$')
goldAgeCount dw 0 

displayOrder db 0
nameListCount db 0

beforeId dw 10, 13, "         |  $"
afterId dw "        |  $" 
afterName dw "  |  $"
afterAge dw "          |$"
bronzeIdLoop dw 0
silverIdLoop dw 0
goldIdLoop dw 0 

bronzeNameLoop dw 0
silverNameLoop dw 0
goldNameLoop dw 0 

bronzeAgeLoop dw 0
silverAgeLoop dw 0
goldAgeLoop dw 0

.code
main proc
    mov ax, @data
    mov ds, ax
    
    call LoadArray
    call Member
    
    main endp

loadArray proc
    mov si, 0
    lea bx, bronze1
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze2
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze3
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze4
    mov bronzeStringArray[si], bx
    add si, 2
    lea bx, bronze5
    mov bronzeStringArray[si], bx
    
    mov si, 0
    lea bx, silver1
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver2
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver3
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver4
    mov silverStringArray[si], bx
    add si, 2
    lea bx, silver5
    mov silverStringArray[si], bx
    
    mov si, 0
    lea bx, gold1
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold2
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold3
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold4
    mov goldStringArray[si], bx
    add si, 2
    lea bx, gold5
    mov goldStringArray[si], bx
    
    ret
    LoadArray endp

Member proc
    call ClearScreen
    print memberMenu
    print mbrOpt
    
    mov ah, 01h
    int 21h
    cmp al, 31h
    je RegisterMember
    cmp al, 32h
    je DisplayMember
    cmp al, 33h
    je Exit
    
    call MemberErrorMessage
    
    ret
    Member endp
    
MemberErrorMessage proc
    print mbrOptErrorMsg
    call Pause 
    call Member
    
    ret
    MemberErrorMessage endp

RegisterMember proc
    call ClearScreen
    print registerMbrMenu
    print mbrOpt
    
    mov ah, 01h
    int 21h
    mov tempMbrType, al   ;<----- store either 1, 2 or 3 for member id auto generate according with the option selected
    cmp al, 31h
    je Bronze
    cmp al, 32h
    je Silver
    cmp al, 33h
    je Gold
    cmp al, 34h
    je Member
    
    call RegisterMemberErrorMessage
    
    ret
    RegisterMember endp

RegisterMemberErrorMessage proc
    print newline
    print mbrOptErrorMsg
    call Pause 
    call RegisterMember
    
    ret
    RegisterMemberErrorMessage endp

Bronze proc
    call ClearScreen
    print bronzeMenu
    
    call MemberName
    
    ret
    Bronze endp

Silver proc
    call ClearScreen
    print silverMenu
    
    call MemberName
    
    ret
    Silver endp

Gold proc
    call ClearScreen
    print goldMenu
    
    call MemberName
    
    ret
    Gold endp

MemberName proc
    print newline
    print enterMbrName
    
    mov ah, 0ah
    lea dx, mbrName
    int 21h
    
    cmp nameAct, 0
    je EmptyNameErrorMessage
    cmp nameAct, 1
    je NameCheckX
    cmp nameAct, 10
    je MemberAge
    
    call NameErrorMessage
    
    ret
    MemberName endp

NameErrorMessage proc
    print nameErrorMsg
    call Pause        
    
    cmp tempMbrType, 31h
    je Bronze
    cmp tempMbrType, 32h
    je Silver
    cmp tempMbrType, 33h
    je Gold
    
    ret
    NameErrorMessage endp

EmptyNameErrorMessage proc
    print emptyNameErrorMsg
    call Pause
    
    cmp tempMbrType, 31h
    je Bronze
    cmp tempMbrType, 32h
    je Silver
    cmp tempMbrType, 33h
    je Gold
    
    ret
    EmptyNameErrorMessage endp

NameCheckX proc
    mov si, 0
    cmp mbrNameArray[si], 'X'
    je RegisterMember
    cmp mbrNameArray[si], 'x'
    je RegisterMember
    
    call NameErrorMessage
    
    ret
    NameCheckX endp

MemberAge proc
    print enterMbrAge
    
    mov ah, 0ah
    lea dx, mbrAge
    int 21h
    
    cmp ageAct, 0
    je EmptyAgeErrorMessage
    cmp ageAct, 1
    je AgeCheckX
    cmp ageAct, 2
    je CheckAge
    
    call AgeErrorMessage
    
    ret
    MemberAge endp

AgeErrorMessage proc
    print ageErrorMsg
    call pause
    call MemberAge
    
    ret
    AgeErrorMessage endp

EmptyAgeErrorMessage proc
    print emptyAgeErrorMsg
    call pause
    call MemberAge
    
    ret
    EmptyAgeErrorMessage endp

AgeCheckX proc
    mov si, 0
    cmp mbrAgeArray[si], 'X'
    je RegisterMember
    cmp mbrAgeArray[si], 'x'
    je RegisterMember
    
    call AgeErrorMessage
    
    ret
    AgeCheckX endp

CheckAge proc
    mov si, 0
    cmp mbrAgeArray[si], 30h
    jle AgeErrorMessage
    cmp mbrAgeArray[si], 31h
    je Check8and9
    cmp mbrAgeArray[si], 39h
    jg AgeErrorMessage
    inc si
    cmp mbrAgeArray[si], 30h
    jl AgeErrorMessage
    cmp mbrAgeArray[si], 39h
    jg AgeErrorMessage
    
    call FindMemberId
    
    ret
    CheckAge endp

Check8and9 proc
    mov di, 1
    cmp mbrAgeArray[di], 38h
    je ConfirmAddMember
    cmp mbrAgeArray[di], 39h
    je ConfirmAddMember
    
    call AgeErrorMessage
    
    ret
    Check8and9 endp

FindMemberId proc        
    cmp tempMbrType, 31h
    je DisplayBronze
    cmp tempMbrType, 32h
    je DisplaySilver
    cmp tempMbrType, 33h
    je DisplayGold
    
    ret
    FindMemberId endp

DisplayBronze proc
    print displayMbrId
    mov si, bronzeStringArrayCount    
    mov ah, 09h
    mov dx, bronzeStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplayBronze endp

DisplaySilver proc
    print displayMbrId
    mov si, silverStringArrayCount    
    mov ah, 09h
    mov dx, silverStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplaySilver endp

DisplayGold proc
    print displayMbrId
    mov si, goldStringArrayCount    
    mov ah, 09h
    mov dx, goldStringArray[si]
    int 21h
    call Pause
    call ConfirmAddMember
    
    ret
    DisplayGold endp

ConfirmAddMember proc
    print newline
    print addMbrConfirmation
    
    mov ah, 01h
    int 21h
    
    cmp al, 'y'
    je StoreMember
    cmp al, 'Y'
    je StoreMember
    cmp al, 'n'
    je RegisterMember
    cmp al, 'N'
    je RegisterMember
    
    call AddMemberErrorMessage
    
    ret
    ConfirmAddMember endp

StoreMember proc
    cmp tempMbrType, 31h
    je StoreBronze
    cmp tempMbrType, 32h
    je StoreSilver
    cmp tempMbrType, 33h
    je StoreGold 
    
    ret
    StoreMember endp

AddMemberErrorMessage proc
    print confirmationErrorMsg
    call Pause
    
    call ConfirmAddMember
    
    ret
    AddMemberErrorMessage endp

StoreBronze proc
    ;store member id
    mov si, mbrIdCount 
    mov al, 'B'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, bronzeCount
    add al, 30h
    mov mbrIdCharacterArray[si], al 
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc bronzeCount
    inc mbrIdCount
    add bronzeStringArrayCount, 2 
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, bronzeNameCount
    b1:
    mov al, mbrNameArray[si]
    mov bronzeNameArray[di], al
    inc si
    inc di
    inc bronzeNameCount
    loop b1
    
    mov al, ','
    mov bronzeNameArray[di], al
    inc bronzeNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, bronzeAgeCount
    b2:
    mov al, mbrAgeArray[si]
    mov bronzeAgeArray[di], al
    inc si
    inc di
    inc bronzeAgeCount
    loop b2
    
    mov al, ','
    mov bronzeAgeArray[di], al
    inc bronzeAgeCount
    
    print addMbrSuccessful
    call Pause
    
    call Member  
    
    ret
    StoreBronze endp

StoreSilver proc
    ;store member id
    mov si, mbrIdCount 
    mov al, 'S'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, silverCount
    add al, 30h
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc silverCount
    inc mbrIdCount
    add silverStringArrayCount, 2
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, silverNameCount
    s1:
    mov al, mbrNameArray[si]
    mov silverNameArray[di], al
    inc si
    inc di
    inc silverNameCount
    loop s1
    
    mov al, ','
    mov silverNameArray[di], al
    inc silverNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, silverAgeCount
    s2:
    mov al, mbrAgeArray[si]
    mov silverAgeArray[di], al
    inc si
    inc di
    inc silverAgeCount
    loop s2
    
    mov al, ','
    mov silverAgeArray[di], al
    inc silverAgeArray 
    
    print addMbrSuccessful
    call Pause
    
    call Member
    
    ret
    StoreSilver endp

StoreGold proc   
    ;store member id
    mov si, mbrIdCount 
    mov al, 'G'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, '0'
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, goldCount
    add al, 30h
    mov mbrIdCharacterArray[si], al
    inc si
    mov al, ','
    mov mbrIdCharacterArray[si], al
    mov mbrIdCount, si
    inc goldCount
    inc mbrIdCount
    add goldStringArrayCount, 2
    
    ;store member name
    mov si, 0      
    mov cx, 10
    mov di, goldNameCount
    g1:
    mov al, mbrNameArray[si]
    mov goldNameArray[di], al
    inc si
    inc di
    inc goldNameCount
    loop g1
    
    mov al, ','
    mov goldNameArray[di], al
    inc goldNameCount
    
    ;store member age
    mov si, 0
    mov cx, 2
    mov di, goldAgeCount
    g2:
    mov al, mbrAgeArray[si]
    mov goldAgeArray[di], al
    inc si
    inc di
    inc goldAgeCount
    loop g2
    
    mov al, ','
    mov goldAgeArray[di], al
    inc goldAgeArray
    
    print addMbrSuccessful
    call Pause
    
    call Member 
    
    ret
    StoreGold endp

DisplayMember proc
    call ClearScreen
    print memberList
    
    call DisplayBronzeList
    
    ret
    DisplayMember endp

DisplayBronzeList proc 
    mov si, 0
    mov ax, bronzeStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov bronzeIdLoop ,ax
    
    bl1:
    mov ax,bronzeIdLoop
    cmp ax, 1
    je DisplaySilverList
    mov cx, ax
     
    print beforeId
    mov dx, bronzeStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, bronzeNameLoop
    mov cx, 10
    bl2:
    mov ah, 02h
    mov dl, bronzeNameArray[di]
    int 21h
    inc di
    inc bronzeNameLoop
    loop bl2
    
    inc bronzeNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, bronzeAgeLoop
    mov cx, 2
    bl3:
    mov ah, 02h
    mov dl, bronzeAgeArray[di]
    int 21h
    inc di
    inc bronzeAgeLoop
    loop bl3
    
    inc bronzeAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec bronzeIdLoop
    mov cx, bronzeIdLoop
    loop bl1
    
    mov bronzeNameLoop, 0
    mov bronzeAgeLoop, 0
    
    call DisplaySilverList  
    
    ret
    DisplayBronzeList endp

DisplaySilverList proc
    mov si, 0
    mov ax, silverStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov silverIdLoop ,ax
    
    sl1:
    mov ax,silverIdLoop
    cmp ax, 1
    je DisplayGoldList
    mov cx, ax
     
    print beforeId
    mov dx, silverStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, silverNameLoop
    mov cx, 10
    sl2:
    mov ah, 02h
    mov dl, silverNameArray[di]
    int 21h
    inc di
    inc silverNameLoop
    loop sl2
    
    inc silverNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, silverAgeLoop
    mov cx, 2
    sl3:
    mov ah, 02h
    mov dl, silverAgeArray[di]
    int 21h
    inc di
    inc silverAgeLoop
    loop sl3
    
    inc silverAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec silverIdLoop
    mov cx, silverIdLoop
    loop sl1
    
    mov silverNameLoop, 0
    mov silverAgeLoop, 0 
    
    call DisplayGoldList 
    
    ret
    DisplaySilverList endp

DisplayGoldList proc
    mov si, 0
    mov ax, goldStringArrayCount
    mov bl, 2
    div bl
    inc ax 
    mov goldIdLoop ,ax
    
    gl1:
    mov ax,goldIdLoop
    cmp ax, 1
    je PressAnyToContinue
    mov cx, ax
     
    print beforeId
    mov dx, goldStringArray[si]
    mov ah, 09h
    int 21h
    mov ah, 09h
    lea dx, afterId
    int 21h
    add si, 2
    
    mov di, goldNameLoop
    mov cx, 10
    gl2:
    mov ah, 02h
    mov dl, goldNameArray[di]
    int 21h
    inc di
    inc goldNameLoop
    loop gl2
    
    inc goldNameLoop
    inc di
    
    mov ah, 09h
    lea dx, afterName
    int 21h
    
    mov di, goldAgeLoop
    mov cx, 2
    gl3:
    mov ah, 02h
    mov dl, goldAgeArray[di]
    int 21h
    inc di
    inc goldAgeLoop
    loop gl3
    
    inc goldAgeLoop
    mov ah, 09h
    lea dx, afterAge
    int 21h 
    
    dec goldIdLoop
    mov cx, goldIdLoop
    loop gl1
    
    mov goldNameLoop, 0
    mov goldAgeLoop, 0   
    
    call PressAnyToContinue
    
    ret
    DisplayGoldList endp

PressAnyToContinue proc
    print memberListEnd
    print newline
    print continue
    call Pause
    
    call Member
    
    ret
    PressAnyToContinue endp

ClearScreen proc
    mov ah, 00
    mov al, 02
    int 10h
    ret
    ClearScreen endp

Pause proc

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
    Pause endp

Exit proc
    mov ax, 4c00h
    int 21h
    ret
    Exit endp
end mains