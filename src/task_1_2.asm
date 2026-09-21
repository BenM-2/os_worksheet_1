%include "asm_io.inc"

segment.data
    msg1    db  "Enter a Number: ", 0   ;
    msg2    db  "The sum of ",0          ;
    msg3    db  " and ",0                 ;
    msg4    db  " is ",0                  ;
segment .bss
    integer1    resd    1   ; First int
    integer2    resd    1   ; Second int
    result      resd    1   ; Result
segment .text
    global asm_main
    asm_main: 
        enter 0,0
        pusha
        ; Print enter msg
        mov eax, msg1       ; Move the Pointer to msg1 into eax
        call print_string   ; Call print string on the pointer
        ; Read int into integer 1
        call read_int       ; Read the first int into integer into eax
        mov [integer1], eax ; save value held in eax to intgeter 1
        ; Print enter msg
        mov eax, msg1       ; Move the Pointer to msg1 into eax
        call print_string   ; Call print string on the pointer
        ; Read int into integer 2
        call read_int       ; Read the first int into integer into eax
        mov [integer2], eax ; save value held in eax to intgeter 2
        ; Sum int 1 and int 2
        mov eax,[integer1]  ; int 1 -> eax
        add eax,[integer2]  ; int 1 + int 2 -> eax
        mov [result],eax    ; Save eax -> result
        ; Print Result statement
        mov eax,msg2        ; Load pointer to msg 2
        call print_string   ; Call print string on the pointer 
        mov eax,[integer1]  ; Load int 1 into eax for printing
        call print_int      ; Call print int to print the value of int 1
        mov eax, msg3       ; Load Pointer to msg 3 into eax
        call print_string   ; Call print string on the pointer
        mov eax,[integer2]  ; Load int 2 into eax for printing
        call print_int      ; Call print int to print the value of int 2
        mov eax, msg4       ; Load pointer to msg4 into eax
        call print_string   ; Call print string on the poiner
        mov eax,[result]    ; Load final result into eax
        call print_int      ; Print result 
        call print_nl       ; Print \n
        popa
        mov eax,0
        leave
        ret