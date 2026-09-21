%include "asm_io.inc"

segment.data
    msg1    db  "Enter Number: ",0  ; Enter number string   
    welcome db  "Welcome",0         ; Welcome String
    lt50    db  "Enter a number > 50 ",0 ; 
    gt100   db  "Enter a number < 100",0 ;
    fifty   dd  50                  ; Number 50
segment .bss
    repeats resd    1   ; Reserve space for Number of repeats
segment .text
    global asm_main
    asm_main: 
        enter 0,0
        pusha
        jmp Enter_Number
    
    Enter_Number
        mov eax,msg1        ;Print "Enter Number: " 
        call print_string   ; 

        call read_int
        mov [repeats],eax   ; Save current value for read ints
        cmp eax, 50    ; 
        JNC GTE_50
        jmp LT_50
    
    LT_50:
        ; Print Err and jmp to Enter_Number Again
        call print_nl
        mov eax,lt50
        call print_string
        call print_nl
        jmp Enter_Number

    GTE_50:
        ; Passed First Test 
        cmp eax, 100
        jc LTE_100
        call print_int
        jmp GT_100

    LTE_100:
        call print_nl
        jmp Print_for_X

    GT_100:
        ; Print Err and jmp to Enter_Number Again
        call print_nl
        mov eax,gt100
        call print_string
        call print_nl
        jmp Enter_Number
        

    Print_for_X:
        ; Print Welcome message
        mov eax,welcome
        call print_string
        call print_nl
        ; Decrement loop
        mov eax,[repeats]
        sub eax,1
        mov [repeats],eax
        jz Close_Program 
        jnz Print_for_X


    Close_Program:
        popa
        mov eax,0
        leave
        ret