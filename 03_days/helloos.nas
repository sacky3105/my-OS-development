; helloos.nas - A simple bootloader that does nothing

[ORG 0x7C00]

; 無限ループで停止
jmp $

times 510-($-$$) db 0
dw 0xAA55
