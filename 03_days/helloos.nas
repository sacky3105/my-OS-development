; helloos.nas - A simple bootloader

[ORG 0x7C00]

; BIOSが読み込んでくれるメッセージ
mov ax, 0x0000
mov ds, ax
mov si, msg
call print_string

; 無限ループで停止
jmp $

print_string:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    int 0x10
    jmp print_string
.done:
    ret

msg db 'Hello, OS!', 0

times 510-($-$$) db 0
dw 0xAA55
