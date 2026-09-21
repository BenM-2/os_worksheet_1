%include "asm_io.inc"

segment.data
    ; DX directives 
segment .bss
    ; RESX directives
segment .text
    global asm_main
    asm_main: 
        enter 0,0
        pusha
        ; Program here
        popa
        mov eax,0
        leave
        ret