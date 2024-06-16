ORG     0x7c00

;フロッピーディスクの詳細
        JMP     entry
        DB      0x90
        DB      "HARIBOTE"
        DW      512
        DB      1
        DW      1
        DB      2
        DW      224
        DW      2880
        DB      0xf0
        DW      9
        DW      18
        DW      2
        DD      0
        DD      2880

    ; FAT12/16におけるオフセット36以降のフィールド
        DB      0,0,0x29
        DD      0xffffffff
        DB      "HARIBOTEOS"
        DB      "FAT12   "
        TIMES    18     DB 0

; START BS_BootCode 64(0x14)    448(0x1C0)
entry:
        MOV     AX, 0
        MOV     SS, AX
        MOV     SP, 0x7c00
        MOV     DS, AX
        ;MOV     ES, AX

        ;MOV     SI, msg

; load disk
        MOV     AX, 0x0820
        MOV     ES, AX
        MOV     CH, 0
        MOV     DH, 0
        MOV     CL, 2

        MOV     AH, 0x02
        MOV     AL, 1
        MOV     BX, 0
        MOV     DL, 0x00
        INT     0x13
        JC      error

fin:
        HTL
        JMP     fin

error:
        MOV     SI, msg

putloop:
        MOV     AL, [SI]
        ADD     SI, 1
        CMP     AL, 0
        JE      fin

        MOV     AH, 0x0e
        MOV     BX, 15
        INT     0x10
        JMP     putloop

msg:
        DB      0x0a, 0x0a
        DB      "load error"
        DB      0x0a
        DB      0

        TIMES   (0x7dfe - 0x7c00 - ($ - $$)) DB 0

        DB      0x55, 0xaa
