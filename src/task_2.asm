%include "asm_io.inc"

segment .data
    name_input  db  "Enter Name: ",0            ; 
    msg1        db  "Enter Number: ",0          ; Enter number string  
    welcome     db  "Welcome ",0                ; Welcome String
    lt50        db  "Enter a number > 50 ",0    ; 
    gt100       db  "Enter a number < 100",0    ;
segment .bss
    repeats             resd    1   ; Reserve space for Number of repeats
    user_name           resd    50  ; Reserve 50 bytes = 49 chars + null termination
    user_name_length    resd    1   ; length for user_name_length 
segment .text
    global asm_main
    asm_main: 
        enter 0,0
        pusha
;       
;       ecx : user_name_length        
;       edi : ptr -> user_name + ecx
;
        mov eax, name_input ; "Enter Name: " -> eax 
        call print_string   ; print Enter Name:
        ; Prep registers
        mov ecx,0           ; set intial length to 0
        mov edi,user_name   ; Set edi -> start of user_name
        jmp Get_Name        ; Start to take input
    Get_Name:
        call read_char      ; Consume First char of stdin
        mov [edi],eax       ; Save char -> username
        
        cmp eax, 10         ; check for \n
        je  Get_Name_End    ; If newline replace it with null terminator 

        cmp edi,50          ; check if len = 50
        je  Get_Name_End    ; If len = 50 replace last character with a null terminator

        inc ecx
        inc edi
        jmp Get_Name
    Get_Name_End: 
        mov byte [edi],0
        jmp Enter_Number
    Enter_Number:
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
        call print_string   ; print "Welcome "
        mov eax, user_name  ; user_name -> eax
        call print_string   ; print "User_name"
        call print_nl       ; print \n
        ; Decrement loop
        mov eax,[repeats]   ; repeat -> eax
        dec eax             ; decrement 
        mov [repeats],eax   ; repeat = repeat -1
        jz Close_Program    ; if repeat = 0 jmp -> close
        jnz Print_for_X     ; else: restart Loop


    Close_Program:
        popa
        mov eax,0
        leave
        ret