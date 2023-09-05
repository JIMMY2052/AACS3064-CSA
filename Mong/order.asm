.model small
.stack 100
.data

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
item_menu db 10, 13, "        -------------------------------------------------------------" 
          db 10, 13, "        |  No.  |                 Item               |  Price (RM)  |" 
          db 10, 13, "        -------------------------------------------------------------" 
          db 10, 13, "        |   1.  |     Everlast Baseball Men's Cap    |     29.00    |" 
          db 10, 13, "        |   2.  |    Under Armour Branded Mens Cap   |     39.00    |" 
          db 10, 13, "        |   3.  |        Puma Pioneer Backpack       |     55.00    |" 
          db 10, 13, "        |   4.  |     Decathlon Trekking Backpack    |     49.00    |" 
          db 10, 13, "        |   5.  |          Unisex Sport Socks        |     27.00    |" 
          db 10, 13, "        |   6.  |    Nike Grip Dri-FIT Studio Socks  |     45.00    |" 
          db 10, 13, "        -------------------------------------------------------------", 0dh, 0ah, "$"

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
item_price_sen dw 45, 00, 00, 59, 99, 00

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

; total number of orders
num_of_order db 0

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ORDER FUNCTION
    call orderFunction
    mov ax, 4c00h
    int 21h
main endp

; ORDER FUNCTION
orderFunction proc
    call clearCartItem
    checkExit:
        call orderMenu

        cmp check_exit_order, 'X'       ; exit
        je exitOrderFunction
        cmp check_exit_order, 'C'       ; view cart
        je startViewCart

        call promptContinueOrder
        cmp check_continue_order, 'N'   ; not continue order
        je startViewCart
        loop checkExit

    startViewCart:
        call CLS
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
        call CLS
        call printItemMenu
        call promptOrder
    ret
orderMenu endp

; ITEM MENU
printItemMenu proc
    call CLS

    mov ah, 09h
    lea dx, order_logo
    int 21h

    mov ah, 09h
    lea dx, item_menu
    int 21h
    ret
printItemMenu endp

; PROMPT ORDER
promptOrder proc
    mov check_exit_order, 'N'
    mov check_go_to_payment, 'N'

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
    
    ; go to view cart
    gotoViewCart:
        mov check_continue_order, 'N'

    ; continue order
    continueOrder:
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
    call converter

    mov ah, 02h
    mov dl, '.'
    int 21h

    ; Price (sen)
    mov ax, item_price_sen[si]
    call converter
    mov ax, item_price_sen[si]
    call printZero

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

; CONVERTER
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