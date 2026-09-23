%include "asm_io.inc"

segment .data
    arr dd  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100
    range_lower_enter   db  "Enter lower bound: ",0         ; 
    range_lower_err     db  "Lower bound >= 1 ",0           ;
    range_upper_enter   db  "Enter upper bound: ",0         ;
    range_upper_err     db  "Upper bound <= 100 ",0         ;
    range_lt_lower      db  "Upper bound > lower bound",0   ;
    loop_count          dd  -1                              ; Reserve loop count
    sum_text1           db  "The sum of ",0                 ; 
    sum_text2           db  " to ",0                        ;  
    sum_text3           db  " is ",0                        ;
segment .bss
    range_upper_int resd    1   ; Reserve upper bound 
    range_lower_int resd    1   ; Reserve lower bound
    
    count           resd    1   ; Reserve total count
segment .text
    global asm_main
    asm_main: 
        enter 0,0
        pusha

    enter_lower:        
        mov eax,range_lower_enter
        call print_string
        call read_int
        cmp eax,1
        jl err_lower
        mov [range_lower_int],eax

    enter_upper:
        mov eax, range_upper_enter
        call print_string
        call read_int
        cmp eax,100
        jg err_upper
        cmp eax, [range_lower_int]
        jl err_upper_lt_lower
        mov [range_upper_int],eax
        jmp count_loop

    err_lower:
        mov eax,range_lower_err
        call print_string
        call print_nl
        jmp enter_lower
    err_upper:
        mov eax,range_upper_err
        call print_string
        call print_nl
        jmp enter_upper

    err_upper_lt_lower:
        mov eax,range_lt_lower
        call print_string
        call print_nl
        jmp enter_upper
    
    count_loop:
        ; Adding
        mov ebx,[range_lower_int]   ; ebx = range_lower_int
        add ebx,[loop_count]        ; ebx = loop_count + range_lower_int
        mov eax,[arr+ebx*4]         ; Load the current index (arr ptr + index * index_size) into eax 
        add eax,[count]             ; Add current count to number
        mov [count],eax             ; Save count back to mem
        ; loop increment
        mov eax,[loop_count]
        add eax,1
        mov [loop_count],eax
        ;loop break check
        add eax,[range_lower_int]
        cmp eax,[range_upper_int]
        je print_count
        jmp count_loop

    print_count:
        
        mov eax,sum_text1
        call print_string

        mov eax,[range_lower_int]
        call print_int

        mov eax,sum_text2
        call print_string

        mov eax,[range_upper_int]
        call print_int

        mov eax,sum_text3
        call print_string

        mov eax,[count]
        call print_int
        call print_nl

    close_program:
        popa
        mov eax,0
        leave
        ret