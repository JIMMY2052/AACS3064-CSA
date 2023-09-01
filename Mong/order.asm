.model small
.stack 64
.data

; newline
order_newline db 0dh, 0ah, "$"

; sportxpert, order & cart logo
order_sportxpert_logo db 0dh, 0ah, " __                  _  __  __                _   ", 0dh, 0ah, "/ _\_ __   ___  _ __| |_\ \/ /_ __   ___ _ __| |_ ", 0dh, 0ah, "\ \| '_ \ / _ \| '__| __|\  /| '_ \ / _ \ '__| __|", 0dh, 0ah, "_\ \ |_) | (_) | |  | |_ /  \| |_) |  __/ |  | |_ ", 0dh, 0ah, "\__/ .__/ \___/|_|   \__/_/\_\ .__/ \___|_|   \__|", 0dh, 0ah, "   |_|                       |_|                  ", 0dh, 0ah, "$"
order_logo db 0dh, 0ah, "   ____  _____  _____  ______ _____  ", 0dh, 0ah, "  / __ \|  __ \|  __ \|  ____|  __ \ ", 0dh, 0ah, " | |  | | |__) | |  | | |__  | |__) |", 0dh, 0ah, " | |  | |  _  /| |  | |  __| |  _  / ", 0dh, 0ah, " | |__| | | \ \| |__| | |____| | \ \ ", 0dh, 0ah, "  \____/|_|  \_\_____/|______|_|  \_\", 0dh, 0ah, "$"
order_cart_logo db 0dh, 0ah, "   _____          _____ _______ ", 0dh, 0ah, "  / ____|   /\   |  __ \__   __|", 0dh, 0ah, " | |       /  \  | |__) | | |   ", 0dh, 0ah, " | |      / /\ \ |  _  /  | |   ", 0dh, 0ah, " | |____ / ____ \| | \ \  | |   ", 0dh, 0ah, "  \_____/_/    \_\_|  \_\ |_|   ", 0dh, 0ah, "$"

; item
order_item db 0dh, 0ah, "-----------------------------------------------------------------", 0dh, 0ah, "|  No.  |                  Item                  |  Price (RM)  |", 0dh, 0ah, "-----------------------------------------------------------------", 0dh, 0ah, "|   1.  |       Everlast Baseball Men's Cap      |     29.00    |", 0dh, 0ah, "|   2.  |      Under Armour Branded Mens Cap     |     39.00    |", 0dh, 0ah, "|   3.  |          Puma Pioneer Backpack         |     55.00    |", 0dh, 0ah, "|   4.  |       Decathlon Trekking Backpack      |     49.00    |", 0dh, 0ah, "|   5.  |            Unisex Sport Socks          |     27.00    |", 0dh, 0ah, "|   6.  |      Nike Grip Dri-FIT Studio Socks    |     45.00    |", 0dh, 0ah, "-----------------------------------------------------------------", 0dh, 0ah, "$"

; order prompt
order_item_prompt db 0dh, 0ah, "Enter Item No. (Press C to view cart): $"
order_qty_prompt db 0dh, 0ah, "Enter quantity (1 - 9): $"
order_continue_prompt db 0dh, 0ah, "Continue ordering? (Y/N) $"

; invalid message
invalid_order_item db, 0dh, 0ah, "Invalid Item No.! Please enter again.$"
invalid_order_qty db, 0dh, 0ah, "Invalid Order Quantity! Please enter a quantity between 1 - 9.$"
invalid_input db, 0dh, 0ah, "Invalid input! Please enter again.$"

; cart item
cart_item db 0dh, 0ah, "------------------------------------------------------------------------------------------------------", 0dh, 0ah,
                       "|  No.  |                  Item                  |  Price (RM)  |  Quantity  |  Subtotal Price (RM)  |", 0dh, 0ah,
                       "------------------------------------------------------------------------------------------------------", 0dh, 0ah,

.code
main proc
mov ax, @data
mov ds, ax

printOrderLogo:
    mov ah, 00 
    mov al, 02
    int 10h

    mov ah, 09h
    lea dx, order_sportxpert_logo
    int 21h

    mov ah, 09h
    lea dx, order_logo
    int 21h

printItem:
    mov ah, 09h
    lea dx, order_item
    int 21h

promptItem:
    mov ah, 09h
    lea dx, order_item_prompt
    int 21h

    mov ah, 01h
    int 21h

    cmp al, 63h
    je viewCart
    cmp al, 43h
    je viewCart
    sub al, 30h
    cmp al, 1
    jl printInvalidOrderItem
    cmp al, 6
    jg printInvalidOrderItem

promptQty:
    mov ah, 09h
    lea dx, order_qty_prompt
    int 21h

    mov ah, 01h
    int 21h

    sub al, 30h
    cmp al, 1
    jl printInvalidOrderQty
    cmp al, 9
    jg printInvalidOrderQty
    jmp orderContinuePrompt

printInvalidOrderItem:
    mov ah, 09h
    lea dx, invalid_order_item
    int 21h
    jmp promptItem

printInvalidOrderQty:
    mov ah, 09h
    lea dx, invalid_order_qty
    int 21h
    jmp promptQty

orderContinuePrompt:
    mov ah, 09h
    lea dx, order_continue_prompt
    int 21h

    mov ah, 01h
    int 21h

    cmp al, 79h
    je printOrderLogo
    cmp al, 59h
    je printOrderLogo
    cmp al, 6eh
    je viewCart
    cmp al, 4eh
    je viewCart
    jne printInvalidInput

printInvalidInput:
    mov ah, 09h
    lea dx, invalid_input
    int 21h
    jmp orderContinuePrompt

viewCart:
    mov ah, 00 
    mov al, 02
    int 10h

    mov ah, 09h
    lea dx, order_cart_logo
    int 21h


mov ax, 4c00h
int 21h

main endp
end main