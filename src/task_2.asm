%include "asm_io.inc"

segment.data
    msg1    db  "Enter Number: ",0  ; Enter number string   
    welcome db  "Welcome",0         ; Welcome String
    lt50    db  "Enter a number > 50 ",0 ; 
    gt100   db  "Enter a number < 100",0 ;
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
        
        cmp eax, 50         ; if eax >= 50  
        jnc GTE_50          ; jmp -> GTE_50 
        jmp LT_50           ; else: jmp -> LT_50 (Error Message)
    
    LT_50:
        ; Print Err and jmp to Enter_Number Again
        call print_nl
        mov eax,lt50
        call print_string
        call print_nl
        jmp Enter_Number    ; Re Enter Number 

    GTE_50:
        ; Passed First Test 
        cmp eax, 100        ; if eax <= 100 
        jc LTE_100          ; jmp LTE_100 
        jmp GT_100          ; else: jmp -> GT_100 (Error Message)

    LTE_100:
        call print_nl       ; Call print_nl for formating
        jmp Print_for_X     ; Start loop to print Welcome for length of loop

    GT_100:
        ; Print Err and jmp to Enter_Number Again
        call print_nl
        mov eax,gt100
        call print_string
        call print_nl
        jmp Enter_Number
        

    Print_for_X:
        ; Print Welcome message
        mov eax,welcome     ; welcome -> eax
        call print_string   ; print "Welcome"
        call print_nl       ; print \n
        ; Decrement loop
        mov eax,[repeats]   ; repeat -> eax
        sub eax,1           ; decrement 
        mov [repeats],eax   ; repeat = repeat -1
        jz Close_Program    ; if repeat = 0 jmp -> close
        jnz Print_for_X     ; else: restart Loop


    Close_Program:
        popa
        mov eax,0
        leave
        ret