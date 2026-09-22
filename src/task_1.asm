%include "asm_io.inc"

segment.data
    integer1    dd  10  ; First Int
    integer2    dd  66  ; Second Int
segment .bss
    result  resd    1   ; Result
segment .text
    global asm_main
    asm_main: 
        enter 0,0
        pusha
        mov eax,[integer1]  ; load first int
        add eax,[integer2]  ; Add second int  
        mov [result],eax    ; save eax into result
        call print_int      ; Print the output 
        call print_nl       ; print \n for ease of reading
        popa
        mov eax,0
        leave
        ret