.model small
.stack 100h
.data
PRINT macro msg
    mov ah,09h
    lea dx,msg
    int 21h
    endm
    memberMenu db 10, 13, "                   ----------------------------------------"
           db 10, 13, "                   |             Member Menu              |"
           db 10, 13, "                   ----------------------------------------"
           db 10, 13, "                   |                                      |"
           db 10, 13, "                   |        1. Register Membership        |"
           db 10, 13, "                   |        2. Display Member             |"
           db 10, 13, "                   |        3. Exit                       |"
           db 10, 13, "                   |                                      |"
           db 10, 13, "                   ----------------------------------------$"
           
registerMbrMenu db 10, 13, "             ------------------------------------------------------"
                db 10, 13, "             |                 Register Membership                |"
                db 10, 13, "             ------------------------------------------------------"
                db 10, 13, "             |                                                    |"
                db 10, 13, "             |         1. Bronze Membership (5% discount)         |"
                db 10, 13, "             |         2. Silver Membership (10% discount)        |"
                db 10, 13, "             |         3. Gold Membership (15% discount)          |"
                db 10, 13, "             |         4. Exit                                    |"
                db 10, 13, "             |                                                    |"
                db 10, 13, "             ------------------------------------------------------$"
                   
bronzeMenu db 10, 13, "                ---------------------------------------------"
           db 10, 13, "                |                                           |"
           db 10, 13, "                |        Bronze Member (5% discount)        |"
           db 10, 13, "                |                                           |"
           db 10, 13, "                ---------------------------------------------", 10, 13, "$"
                  
silverMenu db 10, 13, "                ----------------------------------------------"
           db 10, 13, "                |                                            |"
           db 10, 13, "                |        Silver Member (10% discount)        |"
           db 10, 13, "                |                                            |"
           db 10, 13, "                ----------------------------------------------", 10, 13, "$"
                  
goldMenu db 10, 13, "                -------------------------------------------"
         db 10, 13, "                |                                         |"
         db 10, 13, "                |       Gold Member (15% discount)        |"
         db 10, 13, "                |                                         |"
         db 10, 13, "                -------------------------------------------", 10, 13, "$"
                                                                               
memberList db 10, 13, "                 ---------------------------------------------"
           db 10, 13, "                 |                  Member                   |"
           db 10, 13, "                 ---------------------------------------------"
           db 10, 13, "                 |  Member Id  |  MemberName  |  Member Age  |"
           db 10, 13, "                 ---------------------------------------------"
           db 10, 13, "                 |             |              |              |$"
                                   
memberListEnd db 10, 13, "                 |             |              |              |"
              db 10, 13, "                 ---------------------------------------------$"
         
mbrOpt db 10, 13, "                   Enter an option: $"

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

mbrOptErrorMsg db 10, 13, "          Please input a effective number!$"
nameErrorMsg db 10, 13, "          Please input your username exactly 10 characters!$"
emptyNameErrorMsg db 10, 13, "          Please input a username!$"
ageErrorMsg db 10, 13, "          Please only enter age 18 to age 99!$"
emptyAgeErrorMsg db 10, 13, "          Please input your age!$"
confirmationErrorMsg db 10, 13, "          Please input a valid character!$"
mbrFull db 10, 13, "          This member type is already full$"

enterMbrName db 10, 13, "          Enter your username in 10 characters (x = exit): $"
enterMbrAge db 10, 13, "          Enter your age (x = exit) (18 - 99): $"
displayMbrId db 10, 13, "          This is your member id: $"
addMbrConfirmation db 10, 13, "          Confirm to add member (Y/y = yes) (N/n = no)? $"
addMbrSuccessful db 10, 13, "          Your member have added successfully"
continue db 10, 13, "                 Press any key to continue...$"

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

beforeId db 10, 13, "                 |  $"
afterId db "        |  $" 
afterName db "  |  $"
afterAge db "          |$"
bronzeIdLoop dw 0
silverIdLoop dw 0
goldIdLoop dw 0 

bronzeNameLoop dw 0
silverNameLoop dw 0
goldNameLoop dw 0 

bronzeAgeLoop dw 0
silverAgeLoop dw 0
goldAgeLoop dw 0

excedd65535Msg db 10,13,"                    Cannot exceed RM65535.99 !$"
newline db 10,13,"$"
false_login db 0
countLetter dw 0
thankyouMsg db "                    Thank you and Please Come Again.$"
logoutMsg1 db 10,13,10,13,10,13,"                       You have successfully logged out.$"
logoutMsg2 db 10,13,"                       Thank you for using the system!$"
success_loginMsg db 10,13,"                       You have successful login!$"
invalid_ID_password_Msg db 10,13,"                       You have entered invalid user id or password."
                        db 10,13,"                       Press any key to continue...$"
userId_Msg db 10,13,"                       Username (x = exit): $"
pw_Msg db 10,13,"                       Password (x = exit): $"
id db "sportxpert$"
pw db "password$"
invalidMemberIdMsg db 10,13,"                        Invalid Member ID.$"
memberProceedMsg db 10,13,"    Check membership (y) or Back for asking membership (n) > $"
memberid_Arr2 db 50 dup ('$')
hasMembershipMsg db 10,13,"            Do customer has a membership (y = yes , n = no): $"
invalidCharMsg db 10,13,"            Please enter a valid character (y = yes , n = no).",'$'
pressAnytoContinue db 10,13,"                       Press any key to continue...$"
ReadMemberIDMsg db 10,13,10,13,"                        Enter Member ID : $"
correctMemberId db 0
RM db "RM$"
gotMembership db ?
MembershipRate dw ?
BronzeMsg db 10,13,"     This customer is Bronze Membership.  Customer can enjoy 5% discount.$"
SilverMsg db 10,13,"     This customer is Silver Membership.  Customer can enjoy 10% discount.$"
GoldMsg db 10,13,"     This customer is Gold Membership.  Customer can enjoy 15% discount.$"
isDot dw 0
ErrorFound dw 0
tempChar db ?
InvalidAmountPaidMsg db 10,13,"                    Only Accept number (1~9) and a dot (.) $"
InvalidAmountPaidMsg2 db 10,13,"                    Cannot left it blank !$"
AmountPaidCount dw ?
AmountPaidtemp dw ?
exceedDecimal db 0
ReenterAMount db 10,13,"       Only accept 2 Decimal Places! Please re-enter again the amount.$"
whetherGotDecimal db ?
changeCannotBorrow dw 0
grandTotalMsg db "                    Grand Total                 = RM $"
SSTMsg db "                    (+) SST (10%)               = RM $"
DiscountAmount db "                    (-) Membership Discount $"
equalSign db " = RM $"
NetTotalToPay db "                    Net Total                   = RM $"
AmountPaidMsg db "                    Amount Paid                 = RM $"
RoundedNettotalMsg db "                    Amount To Pay               = RM $"
EnterAmount db 10,13,"                    Enter Amount                = RM $"
insufficentMsg db 10,13,"                    Insufficient Amount Paid !$"
ChangesMsg db 10,13,"                    Changes                     = RM $"
RoundingUpMsg db " (Rounded)$"
TotalRoundedUpMsg db "                    Total Rounded               = RM $"
enterYourOptionMsg db "        Enter Your Option --> $"
MainMenuOption db ?
ErrorOptionMsg db "        Please enter a valid number (1 - 5).$"

numOfSale dw 0
totalSalesWholeNum dw 0
totalSalesDecimal12 dw 0

AmountPaid dw ?
AmountPaidDecimal12 dw ?
changeWholeNum dw 0
changeDecimal12 dw 0

RoundedNetTotal dw 0
RoundedNetTotalDecimal12 dw 0


SST dw 10
tempDiscounted dw 0
grandTotal dw 0
grandTotalDecimal12 dw 0
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
MAXmember_Arr DB 4
ACTmember_Arr DB ? 
input_member_Arr DB 4 DUP ('$')
logo db 10,13,"               _____                  _  __   __                _ "  
     db 10,13,"              / ____|                | | \ \ / /               | |"  
     db 10,13,"             | (___  _ __   ___  _ __| |_ \ V / _ __   ___ _ __| |_"
     db 10,13,"              \___ \| '_ \ / _ \| '__| __| > < | '_ \ / _ \ '__| __|"
     db 10,13,"              ____) | |_) | (_) | |  | |_ / . \| |_) |  __/ |  | |_ "
     db 10,13,"             |_____/| .__/ \___/|_|   \__/_/ \_\ .__/ \___|_|   \__|"
     db 10,13,"                    | |                        | |"                  
     db 10,13,"                    |_|                        |_|",10,13,'$'   



Summarylogo db 10,13,"               _____ "                                           
            db 10,13,"              / ____|"                                           
            db 10,13,"             | (___  _   _ _ __ ___  _ __ ___   __ _ _ __ _   _ "
            db 10,13,"              \___ \| | | | '_ ` _ \| '_ ` _ \ / _` | '__| | | |"
            db 10,13,"              ____) | |_| | | | | | | | | | | | (_| | |  | |_| |"
            db 10,13,"             |_____/ \__,_|_| |_| |_|_| |_| |_|\__,_|_|   \__, |"
            db 10,13,"                                                           __/ |"
            db 10,13,"                                                          |___/",10,13,'$' 

Paymentlogo db 10,13,"                   _____                                 _   "
            db 10,13,"                  |  __ \                               | |  "
            db 10,13,"                  | |__) |_ _ _   _ _ __ ___   ___ _ __ | |_ "
            db 10,13,"                  |  ___/ _` | | | | '_ ` _ \ / _ \ '_ \| __|"
            db 10,13,"                  | |  | (_| | |_| | | | | | |  __/ | | | |_ "
            db 10,13,"                  |_|   \__,_|\__, |_| |_| |_|\___|_| |_|\__|"
            db 10,13,"                                _/ |                         "
            db 10,13,"                              |___/                          ",10,13,'$'              
headline db 10,13,"===============================================================================$"

 Receiptlogo db "                           RECEIPT$"

MainMenulogo db 10,13,"               __  __       _         __  __ "                  
             db 10,13,"              |  \/  |     (_)       |  \/  |"                  
             db 10,13,"              | \  / | __ _ _ _ __   | \  / | ___ _ __  _   _"  
             db 10,13,"              | |\/| |/ _` | | '_ \  | |\/| |/ _ \ '_ \| | | |" 
             db 10,13,"              | |  | | (_| | | | | | | |  | |  __/ | | | |_| |" 
             db 10,13,"              |_|  |_|\__,_|_|_| |_| |_|  |_|\___|_| |_|\__,_|",'$'

Main_menu db 10, 13, "        -------------------------------------------------------------" 
          db 10, 13, "                    |   1.          Membership         |" 
          db 10, 13, "                    |   2.          Order              |" 
          db 10, 13, "                    |   3.          Summary            |" 
          db 10, 13, "                    |   4.          Setting            |"
          db 10, 13, "                    |   5.          Logout             |"
          db 10, 13, "        -------------------------------------------------------------" ,"$"

Settinglogo db 10,13,"                         _____      _   _   _"             
             db 10,13,"                        / ____|    | | | | (_)"            
             db 10,13,"                       | (___   ___| |_| |_ _ _ __   __ _" 
             db 10,13,"                        \___ \ / _ \ __| __| | '_ \ / _` |"
             db 10,13,"                        ____) |  __/ |_| |_| | | | | (_| |"
             db 10,13,"                       |_____/ \___|\__|\__|_|_| |_|\__, |"
             db 10,13,"                                                     __/ |"
             db 10,13,"                                                    |___/" ,"$"
    colorMenu db 10, 13, "        -------------------------------------------------------------"
              db 10,13,"                    |  0.          Original                 |"     
              db 10,13,"                    |  1.          Blue                     |" 
              db 10,13,"                    |  2.          Green                    |" 
    	      db 10,13,"                    |  3.          Cyan                     |" 
        	  db 10,13,"                    |  4.          White                    |"
        	  db 10,13,"                    |  5.          Magenta                  |" 
              db 10,13,"                    |  6.          Brown                    |" 
    	      db 10,13,"                    |  7.          Light Gray               |" 
        	  db 10,13,"                    |  8.          Light Blue               |"
        	  db 10, 13, "        -------------------------------------------------------------" ,"$" 
    askColorMsg db 10,13,"        Enter the color you want to change (x = exit): $"
    invalidColorMsg db 10,13,"        Invalid Color Code! Only enter number (0-8).$" 
    
    inputColor db 7; set original color   

processingPaymentMsg db "                              Payment Processing...                   $"
spacing db "                        $"
smallspacing db "   $"
totalDailyOrderMsg db "                       Total Daily Order Made  = $"
totalDailySalesMsg db "                       Total Daily Sales Made  = RM $"
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


; newline
order_newline db 10, 13, "$"

; order & cart logo
order_logo db 10, 13, "                       ____  _____  _____  ______ _____  " 
           db 10, 13, "                      / __ \|  __ \|  __ \|  ____|  __ \ " 
           db 10, 13, "                     | |  | | |__) | |  | | |__  | |__) |" 
           db 10, 13, "                     | |  | |  _  /| |  | |  __| |  _  / " 
           db 10, 13, "                     | |__| | | \ \| |__| | |____| | \ \ " 
           db 10, 13, "                      \____/|_|  \_\_____/|______|_|  \_\", 10, 13, "$"
order_cart_logo db 10, 13, "                         _____          _____ _______ " 
                db 10, 13, "                        / ____|   /\   |  __ \__   __|" 
                db 10, 13, "                       | |       /  \  | |__) | | |   " 
                db 10, 13, "                       | |      / /\ \ |  _  /  | |   " 
                db 10, 13, "                       | |____ / ____ \| | \ \  | |   " 
                db 10, 13, "                        \_____/_/    \_\_|  \_\ |_|   ", 10, 13, "$"

; item menu
item_menu_heading db 10, 13, "        -------------------------------------------------------------" 
          db 10, 13, "        |  No.  |                 Item               |  Price (RM)  |" 
          db 10, 13, "        -------------------------------------------------------------", 10, 13, "$" 
item_menu_space1 db "        $"
item_menu_space2 db "  $"
item_menu_border db "|   $"
item_menu_line db "        -------------------------------------------------------------", 10, 13, "$"

; order prompt
order_item_prompt db 10, 13, "        Enter Item No. (C - View Cart, X - Exit): $"
order_qty_prompt db 10, 13, "        Enter quantity (1 - 9): $"
order_continue_prompt db 10, 13, "        Continue ordering? (Y/N): $"

; invalid message
invalid_order_item db 10, 13, "        Invalid Item No.! Please enter again.$"
invalid_order_qty db 10, 13, "        Invalid Order Quantity! Please enter a quantity between 1 - 9.$"
invalid_input db 10, 13, "        Invalid input! Please enter again.$"

; cart item heading & layout
cart_item_heading db 10, 13, " -----------------------------------------------------------------------------"
                  db 10, 13, " |  No.  |                 Item               |  Price  |  Qty  |  Subtotal  |"
                  db 10, 13, " -----------------------------------------------------------------------------", 10, 13, "$"
cart_item_total_layout db "                                                   Grand Total  |"
cart_item_space db "   $"
cart_item_border db "  |$"

; no item message
no_item_msg db 10, 13, "                         There is no item in the cart."
            db 10, 13, "                         Press any key to continue...$"

; cart instruction
cart_item_line db " -----------------------------------------------------------------------------", 10, 13, "$"
cart_choice_menu db "                           1 - Return to Order"
                 db 10, 13, "                           2 - Cancel order"
                 db 10, 13, "                           3 - Proceed to Payment", 10, 13, "$"

; cart choice prompt
cart_choice_prompt db 10, 13, "                    Enter a choice (1-3): $"

; confirmation
confirm_exit_order db 10, 13, "        Confirm exit order? (Y/N): $"
confirm_cancel_order db 10, 13, "             Confirm cancel order? (Y/N): $"
confirm_payment db 10, 13, "       Confirm proceed to payment? (Y/N): $"

; item & price
items_available dw 6 dup("$")
item1 db "Everlast Baseball Men's Cap    $"
item2 db "Under Armour Branded Mens Cap  $"
item3 db "Puma Pioneer Backpack          $"
item4 db "Decathlon Trekking Backpack    $"
item5 db "Unisex Sport Socks             $"
item6 db "Nike Grip Dri-FIT Studio Socks $"

item_price_ringgit dw 29, 39, 55, 49, 27, 45
item_price_sen dw 00, 00, 00, 00, 00, 00

; cart item quantity & grand total
item_selected db ?
qty_to_add dw ?
qty_items dw 6 dup("$")
qty_item1 dw 0
qty_item2 dw 0
qty_item3 dw 0
qty_item4 dw 0
qty_item5 dw 0
qty_item6 dw 0
current_item_price_ringgit dw 0
current_item_price_sen dw 0
cart_item_grand_total_price_ringgit dw 0
cart_item_grand_total_price_sen dw 0

; check condition
check_exit_order db ?
check_continue_order db ?
check_no_item_qty db 0
check_go_to_payment db ?
num_of_item db 6
countItem dw 6
countMenuItem dw 6

; total number of orders
num_of_order db 0
SalesReportMsg db "                            SportXpert Sales Report", 10, 13, "$"
logoutMsg3 db 10,13,10,13,10,13,"      Do you really want to logout the system? (y = yes or n = no) > $"
logoutInvalidCharMsg db 10,13,"      Invalid Character. Please enter (y = yes or n = no) only! $"
logoutVar db ?
.code
main proc
mov ax,@data
mov ds,ax

call videoMode
call login

backToMainMenu:
call MainMenu
cmp MainMenuOption,1
je JumpToMembershipFunction

cmp MainMenuOption,2
je JumpToOrderFunction

cmp MainMenuOption,3
je JumpToSummaryFunction

cmp MainMenuOption,4
je JumpToSetting

cmp MainMenuOption,5
je JumpToLogout

JumpToMembershipFunction:
call LoadArray 
call Member
jmp backToMainMenu

JumpToOrderFunction:
call orderFunction
cmp check_go_to_payment,'Y'
jne backToMainMenu
call PaymentReceiptAddingSummaryFunction
jmp backToMainMenu

JumpToSummaryFunction:
call summaryFunction
jmp backToMainMenu

JumpToSetting:
call settingFunction
jmp backToMainMenu

JumpToLogout:
call AreYouSureLogout
cmp logoutVar,'y'
je ConfirmLogout
jmp backToMainMenu
ConfirmLogout:
call summaryFunction
print logoutMsg1
print logoutMsg2
mov ah,4ch
int 21h

main endp

AreYouSureLogout proc
askingLogout:
call videoMode
print logoutMsg3
mov ah,01h
int 21h
cmp al,'y'
je yesLogout
cmp al,'Y'
je yesLogout
cmp al,'n'
je NoLogout
cmp al,'N'
je NoLogout
print logoutInvalidCharMsg
print pressAnytoContinue
call pause
jmp askingLogout

yesLogout:
mov logoutVar,'y'
jmp endingAreYouSureLogout

NoLogout:
mov logoutVar,'n'
endingAreYouSureLogout:
ret
AreYouSureLogout endp
summaryFunction proc
call videoMode
print Summarylogo
print newline
print SalesReportMsg
print newline
print totalDailyOrderMsg
mov ax,numOfSale
call converter
print newline
print totalDailySalesMsg
call printTotalSales
print pressAnytoContinue
call pause
ret
summaryFunction endp
PaymentReceiptAddingSummaryFunction proc
call BigPaymentFunction
call receipt
call addingToSummary
ret
PaymentReceiptAddingSummaryFunction endp
MainMenu proc
mainMenuLabel:
call videoMode
mov MainMenuOption,0
print MainMenulogo
print Main_menu
print newline
print enterYourOptionMsg
mov ah,01h
int 21h
sub al,30h
mov MainMenuOption,al
cmp al,1
jl ErrorOption
cmp al,5
jg ErrorOption
jmp endingMainMenu
ErrorOption:
print newline
print ErrorOptionMsg
print pressAnytoContinue
call pause
jmp mainMenuLabel
endingMainMenu:
ret
MainMenu endp
receipt proc
call videoMode
print cart_item_line
print Receiptlogo
print spacing
call printDate
print smallspacing
call printTime
call viewItemCart
print cart_item_line
call printReceiptAllAmount
ret
receipt endp
BigPaymentFunction proc
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
print pressAnytoContinue
call pause
ret
BigPaymentFunction endp
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
mov ax,RoundedNetTotalDecimal12
cmp ax,100
jl endingRoundUP
sub ax,100
mov RoundedNetTotalDecimal12,ax
inc RoundedNetTotal
endingRoundUP:
ret
RoundUpFUNCTION endp
CalculateChangeFUNCTION proc
mov ErrorFound,0
mov changeCannotBorrow,0
mov ax,AmountPaid
cmp ax,RoundedNetTotal
jb insufficientChange
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
mov ax,AmountPaidDecimal12
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
call whetherAmountPaidIsNum
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
whetherAmountPaidIsNum proc
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
checkEnterKey:
inc si
mov al,[PaidAmount_Arr + si]
dec si
cmp al,'.'
je isNotDotLabel
jmp backToDot
mightHaveError:
cmp al,'.'
jne isNotDotLabel
je checkEnterKey
backToDot:
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
whetherAmountPaidIsNum endp
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
jc exceed65535
loop multiplication
addition:
add AmountPaid,ax
jc exceed65535
jmp continueMultiplyAmountPaid
exceed65535:
inc ErrorFound
print excedd65535Msg
print pressAnytoContinue
call pause
jmp endingStoringAmountPaid
continueMultiplyAmountPaid:
cmp AmountPaidCount,0
jnz calculationAmountPaid
endingStoringAmountPaid:
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
cmp AmountPaidCount,1
je itOnly1Decimal
jmp calculationAmountPaidF
itOnly1Decimal:
xor ah,ah
mov al,[PaidAmount_Arr+si]
mov bx,10d
mul bx
add AmountPaidDecimal12,ax
jmp endingstoringAmountWholeNum
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
inc si
mov al,[PaidAmount_Arr+si]
dec si
cmp al,13
je AmountNoDecimalLabel
mov whetherGotDecimal,'y'
jmp endingReadAmountWhether
AmountNoDecimalLabel:
mov whetherGotDecimal,'n'
jmp endingReadAmountWhether
endingReadAmountWhether:
ret
readAmountWhetherGotDecimal endp
paymentFUNCTION proc
call resetAllTheTotal
mov ax,cart_item_grand_total_price_ringgit
mov grandTotal,ax
mov ax,cart_item_grand_total_price_sen
mov grandTotalDecimal12,ax
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
mov grandTotalDiscounted,ax
mov ax,grandTotalDecimal12
mov NetTotalDecimal12,ax
call clear
mov ax,grandTotalDiscounted
mov bx,100;
div bx;
mov grandTotalDiscounted,ax
mov Decimal12Discounted,dx


call clear
mov ax,grandTotalDiscounted
mov bx,MembershipRate
mul bx
mov grandTotalDiscounted,ax
call clear
mov ax,Decimal12Discounted
mov bx,MembershipRate
mul bx
cmp ax,100
mov Decimal12Discounted,ax
jge increaseDicountedGrandTotal
jmp NoincreaseDicountedGrandTotal
increaseDicountedGrandTotal:
mov bx,100
div bx
add grandTotalDiscounted,ax
mov Decimal12Discounted,dx
NoincreaseDicountedGrandTotal:
;----------------------------------------------------
mov ax,NetTotalDecimal12
mov bx,MembershipRate
mul bx
mov tempDiscounted,ax
call clear
mov ax,tempDiscounted
mov bx,100
div bx
add Decimal12Discounted,ax
mov Decimal34Discounted,dx
mov ax,Decimal12Discounted
cmp ax,100
jge Decimal12DiscountedMorethan100
jmp nettotalSubtractDiscount
;----------------------------------------------------
Decimal12DiscountedMorethan100:
sub ax,100
mov Decimal12Discounted,ax
inc grandTotalDiscounted
jmp nettotalSubtractDiscount
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
call videoMode
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
call videoMode
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
call videoMode
jmp MembershipProceedLabel  

;--------------------------------------------------------------------------------------------------

checkMembership:        ; check member id whether it is valid
mov gotMembership,'y'
call ReadMembershipF        ;Read Input of membership   
call validateMemberF        ; Validate Membership Function
mov al,correctMemberId
cmp al,1
je correctMemberIdLabel
print invalidMemberIdMsg
print pressAnytoContinue
call pause
call videoMode
jmp MembershipProceedLabel

correctMemberIdLabel:       ;IF correct Member Id , assign corresponding letter to a variable and print out the membership level + discount rate
mov si,0
mov al,[input_member_Arr + si]
cmp al,'B'
je BronzeJimmy
cmp al,'S'
je SilverJimmy
cmp al,'G'
je GoldJimmy
BronzeJimmy:
 mov MembershipRate,5
print BronzeMsg
print pressAnytoContinue
call pause
 jmp exitMembership
 SilverJimmy:
 mov MembershipRate,10
 print SilverMsg
print pressAnytoContinue
call pause
 jmp exitMembership
 GoldJimmy:
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
mov correctMemberId,0
mov di,0
mov si,0
mov cx,1
sorting1:
mov al,[mbrIdCharacterArray + si]
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
mov al,[mbrIdCharacterArray + si]
mov [memberid_Arr2 + di], al
inc si
inc di
mov al,[mbrIdCharacterArray + si]
mov [memberid_Arr2 + di], al
inc si
inc di
mov al,[mbrIdCharacterArray + si]
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
    dec di
    mov dl,[memberid_Arr2 + di]
    mov tempChar,dl
    mov si,1
    mov al,[input_member_Arr + si]
    inc di
    add di,4
    cmp al,tempChar
    mov al,input_member_Arr[2]
    jne ValidateThirdCharMemberId
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
    call videoMode
    print Paymentlogo
    print headline 
    print newline
    print processingPaymentMsg
    call printDate
    print headline
    print newline
    print grandTotalMsg
    call printoutGrandTotalFUNCTION
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
    print SSTMsg
    call printoutSSTFUNCTION
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
printReceiptAllAmount proc
    print grandTotalMsg
    call printoutGrandTotalFUNCTION
    print newline
    print SSTMsg
    call printoutSSTFUNCTION
    mov al,gotMembership
    cmp al,'n'
    je skipDisplayDiscountAmount1
    print newline
    print DiscountAmount
    mov ax,MembershipRate
    call converter
    mov dl,'%'
    mov ah,02h
    int 21h
    mov ax,MembershipRate
    cmp al,5
    je printSpace1
    jmp backToprintingEqual1
    printSpace1:
    mov dl,32
    mov ah,02h
    int 21h
    backToprintingEqual1:
    print equalSign
    call printoutDiscountedTotalFUNCTION
    skipDisplayDiscountAmount1:
    print newline
    print NetTotalToPay
    call printoutNetTotalFUNCTION
    print newline
    print cart_item_line
    print TotalRoundedUpMsg
    call printRoundedTotal
    print newline
    print AmountPaidMsg
    call printAmountPaid
    print ChangesMsg
    call printChanges
    print newline
    print cart_item_line
    print thankyouMsg
    print newline
    print cart_item_line
    print pressAnytoContinue
    call pause
    ret
printReceiptAllAmount endp
printAmountPaid proc
call clear
mov ax,AmountPaid
call converter
mov ah,02h
mov dl,'.'
int 21h
mov ax,AmountPaidDecimal12
cmp ax,10
jl printAmountPaidDecimal12For0
lp2023:
call clear
mov ax,AmountPaidDecimal12
call converter
jmp endPrintAmoundPaid

printAmountPaidDecimal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp2023
endPrintAmoundPaid:
ret
printAmountPaid endp
addingToSummary proc
call clear
mov ax,RoundedNetTotal
add totalSalesWholeNum,ax
call clear
mov ax,RoundedNetTotalDecimal12
add totalSalesDecimal12,ax
cmp ax,100
jl NoNeedincrease
inc totalSalesWholeNum
sub ax,100
mov totalSalesDecimal12,ax
NoNeedincrease:
inc numOfSale
ret
addingToSummary endp
printTotalSales proc

call clear
mov ax,totalSalesDecimal12
cmp ax,100
jge increasetotalSalesWhole
checkingAgain:
call clear
mov ax,totalSalesWholeNum
call converter
mov ah,02h
mov dl,'.'
int 21h
call clear
mov ax,totalSalesDecimal12
cmp ax,10
jl printTotalSalesDecimal12For0
lp2024:
call clear
mov ax,totalSalesDecimal12
call converter
jmp endPrintTotalSales

increasetotalSalesWhole:
sub ax,100
mov totalSalesDecimal12,ax
inc totalSalesWholeNum
jmp checkingAgain

printTotalSalesDecimal12For0:
mov ah,02h
mov dl,'0'
int 21h
jmp lp2024
endPrintTotalSales:
ret
printTotalSales endp
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
    backNotLogout:
    p1:
    mov bl,[input_idArr+si]
    cmp bl,13
    je idclear
    inc countLetter
    inc si
    inc cx
    loop p1

    logout1:
    mov si,1
    mov bl,[input_idArr+si]
    dec si
    cmp bl,13             
    jne backNotLogout
    print logoutMsg2
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
    backNotLogoutP:
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

    logout2:
    mov si,1
    mov bl,[input_pwArr+si]
    dec si
    cmp bl,13             
    jne backNotLogoutP
    print logoutMsg2
    mov ah,4ch
    int 21h
    
    invalid_pw:
    inc false_login
    jmp checklogin

    unssucessful:
    PRINT invalid_ID_password_Msg
    call pause
    call videoMode
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
    print pressAnytoContinue
    call pause
    
    ret
login endp
settingFunction proc
Setting:
                
                CALL videoMode
                print Settinglogo
                print colorMenu
                print askColorMsg
                mov ah,01h
                int 21h
                cmp al,'0'
                je original
                cmp al,'1'
                je Blue
                cmp al,'2'
                je Green
                cmp al,'3'
                je Cyan
                cmp al,'4'
                je White
                cmp al,'5'
                je Magenta
                cmp al,'6'
                je Brown
                cmp al,'7'
                je LightGrey
                cmp al,'8'
                je LightBlue
                cmp al,'X'
                je endingSettingFunction
                cmp al,'x'
                je endingSettingFunction
            
                print invalidColorMsg
                print pressAnytoContinue                                                          
            	mov ah,08h ;system pause
            	int 21h
                jmp Setting

            original:
                mov bh,07h
                mov inputColor,bh
                jmp Setting
            Blue:  
                mov bh,01h
                mov inputColor,bh
                jmp Setting
                
            Green:    
                mov bh,02h
                mov inputColor,bh
                jmp Setting
                
            Cyan: 
                mov bh,03h
                mov inputColor,bh
                jmp Setting 
                
            White:
                mov bh,0Fh
                mov inputColor,bh
                jmp Setting 
                
            Magenta: 
                mov bh,05h
                mov inputColor,bh
                jmp Setting
            
            Brown: 
                mov bh,06h
                mov inputColor,bh
                jmp Setting 
                
            LightGrey:
                mov bh,08h
                mov inputColor,bh
                jmp Setting
                
            LightBlue: 
                mov bh,09h
                mov inputColor,bh
                jmp Setting 
endingSettingFunction:
ret
settingFunction endp
videoMode proc
    mov ax,0003; al=03 is text Video Mode(act like clear screen Function)
	int 10h
	mov ax,0600h	;al=00 (fullscreen)
    mov bh,inputColor  ;change color
    mov cx,0000h ;row	
    mov dx,184Fh ;column	
    int 10h
    ret
videoMode endp
; ORDER FUNCTION
orderFunction proc
    call clearCartItem
    checkExit:
        call orderMenu

        cmp check_exit_order, 'X'       ; exit
        je promptConfirmExitOrderFunction
        cmp check_exit_order, 'C'       ; view cart
        je startViewCart

        call promptContinueOrder
        cmp check_continue_order, 'N'   ; not continue order
        je startViewCart
        loop checkExit

    startViewCart:
        call videoMode
        call printCartLogo
        call viewItemCart
        call printCartGrandTotal

        ; check if no items were added
        mov al, num_of_item
        cmp al, check_no_item_qty
        je zeroItem
        jne hasItem

        ; no item
        zeroItem:
            call noItemFound
            jmp endViewCart

        ; has item
        hasItem:
            call printCartInstructions

        endViewCart:
            cmp check_exit_order, 'X'       ; exit
            je exitOrderFunction
            cmp check_exit_order, 'C'       ; continue to view cart
            je startViewCart
            cmp check_continue_order, 'Y'   ; continue order
            je checkExit
            cmp check_continue_order, 'N'   ; not continue order
            je exitOrderFunction

    ; Confirm exit ORDER FUNCTION
    promptConfirmExitOrderFunction:
        mov ah, 09h
        lea dx, confirm_exit_order
        int 21h

        mov ah, 01h
        int 21h

        cmp al, 'y'         ; exit order
        je exitOrderFunction
        cmp al, 'Y'         ; exit order
        je exitOrderFunction
        cmp al, 'n'         ; stay order
        je stayInOrderFunction
        cmp al, 'N'         ; stay order
        je stayInOrderFunction
        jne printInvalidExitConfirmation
    
    stayInOrderFunction:
        mov check_continue_order, 'Y'
        mov check_exit_order, 'N'
        jmp checkExit
    
    printInvalidExitConfirmation:
        mov ah, 09h
        lea dx, invalid_input
        int 21h
        jmp promptConfirmExitOrderFunction 

    ; Exit ORDER FUNCTION
    exitOrderFunction:
        ret
orderFunction endp

; ORDER MENU
orderMenu proc
    ; load all items sold into an array
    loadItemsAvailable:
        mov si, 0
        lea bx, item1
        mov items_available[si], bx
        add si, 2

        lea bx, item2
        mov items_available[si], bx
        add si, 2

        lea bx, item3
        mov items_available[si], bx
        add si, 2

        lea bx, item4
        mov items_available[si], bx
        add si, 2

        lea bx, item5
        mov items_available[si], bx
        add si, 2

        lea bx, item6
        mov items_available[si], bx

    ; print order logo
    printOrderLogo:
        call videoMode
        call printItemMenu
        call promptOrder
    ret
orderMenu endp

; ITEM MENU
printItemMenu proc
    call videoMode

    ; order logo
    mov ah, 09h
    lea dx, order_logo
    int 21h

    ; item menu heading
    mov ah, 09h
    lea dx, item_menu_heading
    int 21h

    ; print all items sold
    mov si, 0
    mov di, 1
    mov cx, 6
    mov countMenuItem, 6
    printAllItem:
        mov ah, 09h
        lea dx, item_menu_space1
        int 21h

        mov ah, 09h
        lea dx, item_menu_border
        int 21h

        mov ah, 02h
        mov dl, '0'
        int 21h

        mov ax, di
        mov ah, 02h
        mov dl, al
        add dl, 30h
        int 21h

        call printItemMenuBorder

        mov ah, 09h
        mov dx, items_available[si]
        int 21h

        call printItemMenuBorder
        mov ah, 09h
        lea dx, item_menu_space2
        int 21h

        call printItemMenuPrice

        mov ah, 09h
        lea dx, item_menu_space2
        int 21h

        mov ah, 09h
        lea dx, item_menu_space2
        int 21h

        mov ah, 02h
        mov dl, '|'
        int 21h

        mov ah, 09h
        lea dx, order_newline
        int 21h
    
        mov cx, countMenuItem
        dec countMenuItem
        add si, 2
        inc di
        loop printAllItem
    
    mov ah, 09h
    lea dx, item_menu_line
    int 21h
    ret
printItemMenu endp

; PRINT ITEM MENU BORDER
printItemMenuBorder proc
    mov ah, 09h
    lea dx, item_menu_space2
    int 21h

    mov ah, 09h
    lea dx, item_menu_border
    int 21h
    ret
printItemMenuBorder endp

; PRINT ITEM MENU PRICE
printItemMenuPrice proc
    mov ax, item_price_ringgit[si]
    call printZero
    mov ax, item_price_ringgit[si]
    call converter

    mov ah, 02h
    mov dl, '.'
    int 21h

    mov ax, item_price_sen[si]
    call printZero
    mov ax, item_price_sen[si]
    call converter
    ret
printItemMenuPrice endp

; PROMPT ORDER
promptOrder proc
    mov check_exit_order, 'N'
    mov check_go_to_payment,'N'
    promptItem:
        mov ah, 09h
        lea dx, order_item_prompt
        int 21h

        ; prompt item
        mov ah, 01h
        int 21h

        cmp al, 'c'         ; view cart
        je chooseCart
        cmp al, 'C'         ; view cart
        je chooseCart
        cmp al, 'x'         ; exit order
        je chooseExit
        cmp al, 'X'         ; exit order
        je chooseExit
        sub al, 30h
        cmp al, 1
        jl printInvalidOrderItem    ; less than 1
        cmp al, 6
        jg printInvalidOrderItem    ; more than 6
                    
        ; store item choice
        mov item_selected, al
        jmp promptQty
    
    ; invalid order item
    printInvalidOrderItem:
        mov ah, 09h
        lea dx, invalid_order_item
        int 21h
        jmp promptItem
    
    promptQty:
        mov ah, 09h
        lea dx, order_qty_prompt
        int 21h

        ; prompt qty
        mov ah, 01h
        int 21h

        sub al, 30h
        xor bx, bx
        mov bl, al
        cmp al, 1
        jl printInvalidOrderQty     ; less than 1
        cmp al, 9
        jg printInvalidOrderQty     ; more than 9

        ; add quantity
        mov qty_to_add, bx
        call addItemQty
        jmp exitOrder
    
    ; invalid order quantity
    printInvalidOrderQty:
        mov ah, 09h
        lea dx, invalid_order_qty
        int 21h
        jmp promptQty

    ; choose exit
    chooseExit:
        mov check_exit_order, 'X'
        jmp exitOrder

    ; choose view cart
    chooseCart:
        mov check_exit_order, 'C'
        jmp exitOrder

    ; Exit PROMPT ORDER
    exitOrder:
        ret 
promptOrder endp

; ADD QUANTITY
addItemQty proc
    ; add quantity according to respective selected item
    mov al, item_selected
    mov bx, qty_to_add
    mov bh, 0
    cmp al, 1
    je addItem1
    cmp al, 2
    je addItem2
    cmp al, 3
    je addItem3
    cmp al, 4
    je addItem4
    cmp al, 5
    je addItem5
    cmp al, 6
    je addItem6

    addItem1:
        add qty_item1, bx
        jmp added
    addItem2:
        add qty_item2, bx
        jmp added
    addItem3:
        add qty_item3, bx
        jmp added
    addItem4:
        add qty_item4, bx
        jmp added
    addItem5:
        add qty_item5, bx
        jmp added
    addItem6:
        add qty_item6, bx
        jmp added
    added:
        ret
addItemQty endp

; PROMPT CONTINUE ORDER
promptContinueOrder proc
    orderContinuePrompt:
        mov ah, 09h
        lea dx, order_continue_prompt
        int 21h

        ; prompt continue order
        mov ah, 01h
        int 21h

        cmp al, 'y'         ; continue order
        je continueOrder
        cmp al, 'Y'         ; continue order
        je continueOrder
        cmp al, 'n'         ; not continue order
        je gotoViewCart
        cmp al, 'N'         ; not continue order
        je gotoViewCart
        jne printInvalidInput

    ; invalid input
    printInvalidInput:
        mov ah, 09h
        lea dx, invalid_input
        int 21h
        jmp orderContinuePrompt
    
    ; continue order
    continueOrder:
        mov check_continue_order, 'Y'
        jmp endPromptContinueOrder

    ; go to view cart
    gotoViewCart:
        mov check_continue_order, 'N'
    
    ; end prompt continue order
    endPromptContinueOrder:
        ret

promptContinueOrder endp

; PRINT CART LOGO
printCartLogo proc
    mov ah, 09h
    lea dx, order_cart_logo
    int 21h
    ret
printCartLogo endp

; VIEW ITEM CART
viewItemCart proc
    ; set grand total to 0
    mov cart_item_grand_total_price_ringgit, 0
    mov cart_item_grand_total_price_sen, 0

    ; heading
    mov ah, 09h
    lea dx, cart_item_heading
    int 21h

    ; load all the respective item quantities into an array
    loadItemsQty:
        mov si, 0
        mov bx, qty_item1
        mov qty_items[si], bx
        add si, 2

        mov bx, qty_item2
        mov qty_items[si], bx
        add si, 2

        mov bx, qty_item3
        mov qty_items[si], bx
        add si, 2

        mov bx, qty_item4
        mov qty_items[si], bx
        add si, 2

        mov bx, qty_item5
        mov qty_items[si], bx
        add si, 2

        mov bx, qty_item6
        mov qty_items[si], bx

    ; 6 items
    mov si, 0
    mov di, 1
    mov cx, 6
    mov check_no_item_qty, 0
    mov countItem, 6

    ; print cart item
    printCartItem:
        cmp qty_items[si], 0        ; item quantity != 0
        jne startPrintItemList

        ; no item quantity
        addNoItemQty:
            inc check_no_item_qty
            jmp nextItem

        ; print item list
        startPrintItemList:
            call printItemList
            inc di
        
        ; next item
        nextItem:
            mov cx, countItem
            dec countItem
            add si, 2
            loop printCartItem

    ret
viewItemCart endp

; PRINT ITEM LIST
printItemList proc
    mov ah, 02h
    mov dl, ' '
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    ; No.
    mov ah, 02h
    mov dl, '0'
    int 21h

    mov ax, di
    mov ah, 02h
    mov dl, al
    add dl, 30h
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    ; Item name
    mov ah, 09h
    mov dx, items_available[si]
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    ; Price (ringgit)
    mov ax, item_price_ringgit[si]
    call printZero
    mov ax, item_price_ringgit[si]
    call converter

    mov ah, 02h
    mov dl, '.'
    int 21h

    ; Price (sen)
    mov ax, item_price_sen[si]
    call printZero
    mov ax, item_price_sen[si]
    call converter

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    ; Item quantity
    mov ax, qty_items[si]
    call printZero
    mov ax, qty_items[si]
    call converter

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    mov ah, 09h
    lea dx, cart_item_space
    int 21h

    ; Subtotal
    call calculateSubtotal

    mov ah, 09h
    lea dx, order_newline
    int 21h

    ret
printItemList endp

; CALCULATE SUBTOTAL
calculateSubtotal proc
    call clear
    mov ax, item_price_ringgit[si]
    mov bx, qty_items[si]
    mul bx
    mov current_item_price_ringgit, ax

    call clear
    mov ax, item_price_sen[si]
    mov bx, qty_items[si]
    mul bx
    mov bx, 100
    div bx
    add current_item_price_ringgit, ax
    mov current_item_price_sen, dx

    ; print subtotal (ringgit)
    mov ax, current_item_price_ringgit
    call converter

    mov ah, 02h
    mov dl, '.'
    int 21h

    ; print subtotal (sen)
    mov ax, current_item_price_sen
    call printZero
    mov ax, current_item_price_sen
    call converter

    ; add grand total (ringgit)
    mov ax, current_item_price_ringgit
    add cart_item_grand_total_price_ringgit, ax

    ; add grand total (sen)
    mov ax, current_item_price_sen
    add cart_item_grand_total_price_sen, ax
    ret
calculateSubtotal endp

; PRINT ZERO
printZero proc
    cmp ax, 10
    jl startPrintZero   ; less than 10
    jge endPrintZero    ; at least 10

    ; print zero
    startPrintZero:
        mov ah, 02h
        mov dl, '0'
        int 21h
    
    endPrintZero:
        ret
printZero endp

; PRINT CART GRAND TOTAL
printCartGrandTotal proc
    mov ah, 09h
    lea dx, cart_item_line
    int 21h

    mov ah, 09h
    lea dx, cart_item_total_layout
    int 21h

    ; check if sen is greater than 100
    cmp cart_item_grand_total_price_sen, 100
    jl startPrintGrandTotal

    ; if sen is greater than 100
    call clear
    mov ax, cart_item_grand_total_price_sen
    mov bx, 100
    div bx
    add cart_item_grand_total_price_ringgit, ax
    mov cart_item_grand_total_price_sen, dx

    ; start print grand total
    startPrintGrandTotal:
        ; print grand total (ringgit)
        call clear
        mov ax, cart_item_grand_total_price_ringgit
        call converter

        mov ah, 02h
        mov dl, '.'
        int 21h

        ; print grand total (sen)
        call clear
        mov ax, cart_item_grand_total_price_sen
        call printZero
        mov ax, cart_item_grand_total_price_sen
        call converter

    mov ah, 09h
    lea dx, order_newline
    int 21h

    mov ah, 09h
    lea dx, cart_item_line
    int 21h

    ret
printCartGrandTotal endp

; NO ITEM FOUND
noItemFound proc
    ; press any key to continue
    mov ah, 09h
    lea dx, no_item_msg
    int 21h
    call pause

    mov check_continue_order, 'Y'
    mov check_exit_order, 'N'
    ret
noItemFound endp

; PRINT INSTRUCTIONS
printCartInstructions proc
    ; print choice menu
    mov ah, 09h
    lea dx, cart_choice_menu
    int 21h

    mov ah, 09h
    lea dx, cart_item_line
    int 21h

    ; prompt choice
    promptCartChoice:
        mov ah, 09h
        lea dx, cart_choice_prompt
        int 21h

        mov ah, 01h
        int 21h
        
        sub al, 30h
        cmp al, 1               ; continue order
        je cartContinueOrder
        cmp al, 2               ; cancel order
        je cartCancelOrder
        cmp al, 3               ; go to payment
        je gotoPayment
        jne invalidCartChoice

    ; invalid cart choice
    invalidCartChoice:
        mov ah, 09h
        lea dx, invalid_input
        int 21h
        jmp promptCartChoice

    ; continue order
    cartContinueOrder:
        mov check_continue_order, 'Y'
        mov check_exit_order, 'N'
        jmp endInstruction
    
    ; cancel order
    cartCancelOrder:
        mov ah, 09h
        lea dx, confirm_cancel_order
        int 21h

        ; prompt confirm cancel
        mov ah, 01h
        int 21h

        cmp al, 'Y'         ; cancel order
        je cancelOrder
        cmp al, 'y'         ; cancel order
        je cancelOrder
        cmp al, 'N'         ; no cancel order
        je noCancelOrder
        cmp al, 'n'         ; no cancel order
        je noCancelOrder
        jne invalidCancelOrderChoice
    
    ; invalid cancel order choice
    invalidCancelOrderChoice:
        mov ah, 09h
        lea dx, invalid_input
        int 21h
        jmp cartCancelOrder
    
    ; cancel order
    cancelOrder:
        call clearCartItem
        mov check_continue_order, 'Y'
        mov check_exit_order, 'N'
        jmp endInstruction
    
    ; no cancel order
    noCancelOrder:
        mov check_exit_order, 'C'
        jmp endInstruction
    
    ; go to payment
    gotoPayment:
        mov ah, 09h
        lea dx, confirm_payment
        int 21h

        ; prompt confirm go to payment
        mov ah, 01h
        int 21h

        cmp al, 'Y'             ; go to payment
        je confirmPayment
        cmp al, 'y'             ; go to payment
        je confirmPayment
        cmp al, 'N'             ; don't go to payment
        je notConfirmPayment
        cmp al, 'n'             ; don't go to payment
        je notConfirmPayment
        jne invalidProceedToPayment
        jmp endInstruction
    
    ; confirm payment
    confirmPayment:
        mov check_exit_order, 'X'
        mov check_go_to_payment, 'Y'
        inc num_of_order
        jmp endInstruction
    
    ; not confirm payment
    notConfirmPayment:
        mov check_exit_order, 'C'
        jmp endInstruction
    
    ; invalid proceed to payment choice
    invalidProceedToPayment:
        mov ah, 09h
        lea dx, invalid_input
        int 21h
        jmp gotoPayment

    ; end instruction
    endInstruction:
        ret
printCartInstructions endp

; CLEAR CART ITEM
clearCartItem proc
    mov qty_item1, 0
    mov qty_item2, 0
    mov qty_item3, 0
    mov qty_item4, 0
    mov qty_item5, 0
    mov qty_item6, 0
    mov cart_item_grand_total_price_ringgit, 0
    mov cart_item_grand_total_price_sen, 0
    ret
clearCartItem endp
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
printDate proc
;Day Part
DAY:
MOV AH,2AH    ; To get System Date
INT 21H
MOV AL,DL     ; Day is in DL
AAM
MOV BX,AX
CALL DISP

MOV DL,'/'
MOV AH,02H    ; To Print / in DOS
INT 21H

;Month Part
MONTH:
MOV AH,2AH    ; To get System Date
INT 21H
MOV AL,DH     ; Month is in DH
AAM
MOV BX,AX
CALL DISP

MOV DL,'/'    ; To Print / in DOS
MOV AH,02H
INT 21H

;Year Part
YEAR:
MOV AH,2AH    ; To get System Date
INT 21H
ADD CX,0F830H ; To negate the effects of 16bit value,
MOV AX,CX     ; since AAM is applicable only for AL (YYYY -> YY)
AAM
MOV BX,AX
CALL DISP
ret
printDate endp

DISP PROC
MOV DL,BH      ; Since the values are in BX, BH Part
ADD DL,30H     ; ASCII Adjustment
MOV AH,02H     ; To Print in DOS
INT 21H
MOV DL,BL      ; BL Part 
ADD DL,30H     ; ASCII Adjustment
MOV AH,02H     ; To Print in DOS
INT 21H
RET
DISP ENDP      ; End Disp Procedure
printTime proc
HOUR:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CH     ; Hour is in CH
AAM
MOV BX,AX
CALL DISP

MOV DL,':'
MOV AH,02H    ; To Print : in DOS
INT 21H

;Minutes Part
MINUTES:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,CL     ; Minutes is in CL
AAM
MOV BX,AX
CALL DISP

MOV DL,':'    ; To Print : in DOS
MOV AH,02H
INT 21H

;Seconds Part
Seconds:
MOV AH,2CH    ; To get System Time
INT 21H
MOV AL,DH     ; Seconds is in DH
AAM
MOV BX,AX
CALL DISP
ret
printTime endp
loadArray proc;
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
    call videoMode
    print memberMenu
    print mbrOpt
        
    mov ah, 01h
    int 21h 
    
    cmp al, 31h
    je JmpToRegisterMember    
    cmp al, 32h
    je JmpToDisplayMember  
    cmp al, 33h
    je EndMember
    jmp MemberErrorMessage
    
    JmpToRegisterMember:
    call RegisterMember
    jmp Member
    JmpToDisplayMember:
    call DisplayMember
    jmp Member
    
    MemberErrorMessage:
    print mbrOptErrorMsg
    call Pause 
    jmp Member

    EndMember:  
    ret
    Member endp 

RegisterMember proc
    call videoMode
    print registerMbrMenu
    print mbrOpt
        
    mov ah, 01h
    int 21h
    mov tempMbrType, al   ;<----- store either 1, 2 or 3 for member id auto generate according with the option selected   
    
    cmp al, 31h
    je JmpToBronze1
    cmp al, 32h
    je JmpToSilver1
    cmp al, 33h
    je JmpToGold1
    cmp al, 34h
    je JmpToMember          
    jmp RegisterMemberErrorMessage    
    
    JmpToBronze1:
    call Bronze
    jmp RegisterMember
    JmpToSilver1:
    call Silver 
    jmp RegisterMember
    JmpToGold1:
    call Gold
    jmp RegisterMember
    
    RegisterMemberErrorMessage:
    print newline
    print mbrOptErrorMsg
    call Pause 
    jmp RegisterMember
    
    JmpToMember: 
    ret
    RegisterMember endp

DisplayMember proc
    call videoMode
    print memberList    
    call DisplayBronzeList
    ret
    DisplayMember endp 

Bronze proc
    call videoMode
    print bronzeMenu    
    cmp bronzeCount, 06h
    je JmpToBronzeFull    
    call MemberName
    jmp EndBronze
    
    JmpToBronzeFull:
    call MemberFull
    jmp EndBronze
    
    EndBronze:
    ret
    Bronze endp 

Silver proc
    call videoMode
    print silverMenu    
    cmp silverCount, 06h
    je JmpToSilverFull    
    call MemberName
    jmp EndSilver
    
    JmpToSilverFull: 
    call MemberFull
    jmp EndSilver
    
    EndSilver:
    ret
    Silver endp

Gold proc
    call videoMode
    print goldMenu    
    cmp goldCount, 06h
    je JmpToGoldFull    
    call MemberName
    jmp EndGold
    
    JmpToGoldFull: 
    call MemberFull
    jmp EndGold
    
    EndGold:
    ret
    Gold endp

MemberFull proc
    print mbrFull
    call Pause
    
    ret
    MemberFull endp

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
    je JmpToMemberAge
    jmp JmpToNameErrorMessage
    
    EmptyNameErrorMessage:
    print emptyNameErrorMsg
    call Pause
    jmp CheckMemberType
          
    NameCheckX:
    mov si, 0        
    cmp mbrNameArray[si], 'x'
    je EndMemberName
    cmp mbrNameArray[si], 'X'
    je EndMemberName       
    jmp JmpToNameErrorMessage
    
    JmpToMemberAge:
    call MemberAge
    jmp EndMemberName
    
    JmpToNameErrorMessage:
    print nameErrorMsg
    call Pause            
    jmp CheckMemberType
    
    CheckMemberType:
    cmp tempMbrType, 31h
    je JmpToBronze2
    cmp tempMbrType, 32h
    je JmpToSilver2
    cmp tempMbrType, 33h
    je JmpToGold2
    
    JmpToBronze2:
    call Bronze
    jmp EndMemberName
    JmpToSilver2:
    call Silver
    jmp EndMemberName
    JmpToGold2:
    call Gold
    jmp EndMemberName     
    
    EndMemberName:
    ret
    MemberName endp

MemberAge proc
    print enterMbrAge
        
    mov ah, 0ah
    lea dx, mbrAge
    int 21h
        
    cmp ageAct, 0
    je JmpToEmptyAgeErrorMessage
    cmp ageAct, 1
    je AgeCheckX
    cmp ageAct, 2
    je JmpToCheckAge   
    jmp JmpToAgeErrorMessage1
    
    JmpToEmptyAgeErrorMessage:
    print emptyAgeErrorMsg
    call Pause
    jmp MemberAge
    
    AgeCheckX:
    mov si, 0
    cmp mbrAgeArray[si], 'x'
    je EndMemberAge
    cmp mbrAgeArray[si], 'X'
    je EndMemberAge        
    jmp JmpToAgeErrorMessage1 
    
    JmpToCheckAge:
    call CheckAge
    jmp EndMemberAge
    
    JmpToAgeErrorMessage1:
    print ageErrorMsg
    call Pause
    call MemberAge
    jmp EndMemberAge
    
    EndMemberAge:    
    ret
    MemberAge endp

CheckAge proc
    mov si, 0
    cmp mbrAgeArray[si], 30h
    jle JmpToAgeErrorMessage2
    cmp mbrAgeArray[si], 31h
    je Check8and9
    cmp mbrAgeArray[si], 39h
    jg JmpToAgeErrorMessage2
    inc si
    cmp mbrAgeArray[si], 30h
    jl JmpToAgeErrorMessage2
    cmp mbrAgeArray[si], 39h
    jg JmpToAgeErrorMessage2    
    jmp JmpToFindMemberId 
    
    Check8and9:
    mov di, 1
    cmp mbrAgeArray[di], 38h
    je JmpToFindMemberId
    cmp mbrAgeArray[di], 39h
    je JmpToFindMemberId    
    jmp JmpToAgeErrorMessage2
    
    JmpToAgeErrorMessage2:
    print ageErrorMsg
    call Pause
    call MemberAge
    jmp EndCheckAge
    
    JmpToFindMemberId:
    call FindMemberId
    jmp EndCheckAge
        
    EndCheckAge:
    ret
    CheckAge endp

FindMemberId proc        
    cmp tempMbrType, 31h
    je DisplayBronze
    cmp tempMbrType, 32h
    je DisplaySilver
    cmp tempMbrType, 33h
    je DisplayGold
    
    DisplayBronze:
    print displayMbrId
    mov si, bronzeStringArrayCount    
    mov ah, 09h
    mov dx, bronzeStringArray[si]
    int 21h
    call ConfirmAddMember
    jmp EndFindMemberId
    
    DisplaySilver: 
    print displayMbrId
    mov si, silverStringArrayCount    
    mov ah, 09h
    mov dx, silverStringArray[si]
    int 21h
    call ConfirmAddMember
    jmp EndFindMemberId 
    
    DisplayGold:
    print displayMbrId
    mov si, goldStringArrayCount    
    mov ah, 09h
    mov dx, goldStringArray[si]
    int 21h
    call ConfirmAddMember
    jmp EndFindMemberId
    
    EndFindMemberId:
    ret
    FindMemberId endp

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
    je EndConfirmAddMember
    cmp al, 'N'
    je EndConfirmAddMember   
    jmp AddMemberErrorMessage
    
    StoreMember:
    cmp tempMbrType, 31h
    je JmpToStoreBronzeId
    cmp tempMbrType, 32h
    je JmpToStoreSilverId
    cmp tempMbrType, 33h
    je JmpToStoreGoldId
    
    JmpToStoreBronzeId:
    call StoreBronzeId
    jmp EndConfirmAddMember
    JmpToStoreSilverId:
    call StoreSilverId
    jmp EndConfirmAddMember
    JmpToStoreGoldId:
    call StoreGoldId
    jmp EndConfirmAddMember
    
    AddMemberErrorMessage:
    print confirmationErrorMsg
    call Pause    
    jmp ConfirmAddMember       
    
    EndConfirmAddMember: 
    ret
    ConfirmAddMember endp

StoreBronzeId proc        
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
    call StoreBronzeName
    
    ret
    StoreBronzeId endp

StoreBronzeName proc            
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
    call StoreBronzeAge
    
    ret
    StoreBronzeName endp

StoreBronzeAge proc   
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
    ret
    StoreBronzeAge endp

StoreSilverId proc
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
    call StoreSilverName
    
    ret
    StoreSilverId endp

StoreSilverName proc    
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
    call StoreSilverAge  
    
    ret
    StoreSilverName endp

StoreSilverAge proc    
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
    inc silverAgeCount     
    print addMbrSuccessful
    call Pause    
    ret
    StoreSilverAge endp

StoreGoldId proc  
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
    call StoreGoldName
    
    ret
    StoreGoldId endp

StoreGoldName proc    
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
    call StoreGoldAge
    
    ret
    StoreGoldName endp

StoreGoldAge proc    
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
    inc goldAgeCount    
    print addMbrSuccessful
    call Pause    
    ret
    StoreGoldAge endp

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
    je JmpToDisplaySilverList
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
    
    JmpToDisplaySilverList:   
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
    je JmpToDisplayGoldList
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
    
    JmpToDisplayGoldList:     
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
    je EndList
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
    
    EndList:
    call PressAnyToContinueMbr  
    ret
    DisplayGoldList endp
PressAnyToContinueMbr proc
    print memberListEnd
    print newline
    print continue
    call Pause     
    ret
    PressAnyToContinueMbr endp
end main