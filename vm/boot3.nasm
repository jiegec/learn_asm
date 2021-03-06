bits 16

start:
    call clearScreen
    mov ax, 0x07c0
    mov ds, ax

    mov ax, 0xb800
    mov es, ax

    cld
    mov si, text
    mov di, 0
    mov cx, len
    rep movsw

    mov bx, [number]
    mov si, 10
    xor cx, cx
digit:
    inc cx
    mov ax, bx
    xor dx, dx
    div si
    mov bx, ax
    or dl, 0x30
    push dx
    cmp bx, 0
    jg digit

print:
    pop dx
    mov [es:di], dl
    inc di
    mov byte [es:di], 0x07
    inc di
    loop print

    jmp near $

clearScreen:
    pusha

    mov ax, 0x0700
    mov bh, 0x07
    mov cx, 0x0000
    mov dx, 0x184f
    int 0x10
    
    popa
    ret

text db 'H',0x02,'e',0x02,'l',0x02,'l',0x02,'o',0x02,' ',0x02,'C',0x02,'S',0x02,'T',0x02,' ',0x02
len equ ($ - text) / 2
number dw 72 ; will be printed in reverse form
times 510 - ($ - $$) db 0
dw 0xaa55
