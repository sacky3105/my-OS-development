; haribote.nas - A simple kernel that does nothing

[ORG 0x7E00]

; 無限ループで停止
jmp $

times 510-($-$$) db 0
dw 0xAA55
