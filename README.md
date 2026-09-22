# Worksheet 1

# Task 1
``` assembly
segment.data
    integer1    dd  15  ; First Int
    integer2    dd  6   ; Second Int
```
In this section of code 2 varaibles are initalised as 2 double words = 4 bytes = standard int  in c
When run the output is <br>
![alt text](README_images/task_1_nums_15_6.png)<br>
When these numbers have been changed 
```
segment.data
    integer1    dd  10  ; First Int
    integer2    dd  66  ; Second Int
```
![alt text](README_images/task_1_nums_10_66.png)

This works by simply loading int1 into eax then adding int2 then printing it 


# Task 1_2

I have discovered that the integers are 32 bit signed ints due to adding the 32bit int limit and recieving a negative
``` bash
~/dev/uni-year-2/prep/asm_test$ make task_1_2 && ./build/exec/task_1_2
mkdir -p build/ build/exec/
Enter a Number: 2147483647        
Enter a Number: 2147483647
The sum of 2147483647 and 2147483647 is -2
``` 

Ordinary addition works fine
![alt text](image.png)

letters provide an overflow of some sort: 
![alt text](image-1.png)


# Task 2


For Testing Task 2 to check if all the loops where working correctly i used
``` bash
make task_2 && ./build/exec/task_2 > out.txt 
```
This command builds task 2, runs it and pipes all outputs to out.txt overwriting all previous contents
This allowed for me to see how many times the welcome message was printed using 
``` bash
cat out.txt | grep -o "Welcome" * | wc -l
```

# Task 3 (makefile)

## Folder structure
I designed my makefile to provide this file structure
```
├── build
│   ├── exec
│   │   └── EXECUTABLES
│   └── All Object files
├── src
│   ├── asm_io.asm
│   ├── asm_io.inc
│   ├── driver.c
│   ├── task_1.asm
│   ├── task_1_2.asm
│   ├── task_2.asm
│   └── task_2_2.asm
├── README.md
├── makefile
└── template.asm
```
## Build variables
``` makefile 
SRC = src/
BUILD_DIR = build/
EXE_DIR = $(BUILD_DIR)exec/
NASM_FLAGS = -f elf -I $(SRC)
```
In a makefile variables can be defined as 
``` makefile
Name = value
```
This then allows for the variables to be used like a template and placed in other sections of the code.
To use the variables the syntax is 
``` makefile
$(Variable)
```
For example the 'EXE_DIR' takes the current build directory and then adds the exec directory at the end

## Dir building
In make to build a file in a directory and watch the file the directory must first exist. 
To make sure that all the necessary directorys exist before building the code this rule is used:
``` makefile
dirs: 
	mkdir -p $(BUILD_DIR) $(EXE_DIR)
```
This rule simply attempts to make the directorys and sub directorys if they do not currently exist. 
If the directorys do exist it simply does nothing.

The dirs are built first using
```makefile
$(BUILD_DIR)task_2.o:	$(SRC)task_2.asm | dirs
```
Where | dirs is used to say that dirs has to be done before the building of the task can even start

## Make All 
To build all the tasks run
``` bash
make all
```
or 
``` bash
make 
```
This simply tries to build all the tasks using the ailiases as shown
``` makefile
all: task_1  task_1_2 task_2 task_2_2
```
## Task Building
``` makefile
# Task_2
task_2: $(EXE_DIR)task_2 
$(EXE_DIR)task_2: $(BUILD_DIR)task_2.o $(BUILD_DIR)driver.o $(BUILD_DIR)asm_io.o
	gcc -m32 $(BUILD_DIR)driver.o $(BUILD_DIR)task_2.o $(BUILD_DIR)asm_io.o -o $(EXE_DIR)task_2

$(BUILD_DIR)task_2.o:	$(SRC)task_2.asm | dirs
	nasm $(NASM_FLAGS) $(SRC)task_2.asm -o $(BUILD_DIR)task_2.o
```
To break down the code above: 
``` makefile
task_2: $(EXE_DIR)task_2
```
This is an ailias for task_2 meaning that to build task_2 it can be done through
``` bash
make /build/exec/task_2 
```
or 
```bash
make task_2
```
The reason for the ailiased build is due to make needing the file prefix to watch for file changes for incremental build.
This would mean if I wanted to change the build directory the make command would change with it but by ailiasing task_2 to 
\$(EXE_DIR)task_2, Regardless of what the exe_dir is i can just build with make task_2

## Make clean
To Remove the build directory and everything inside to have a clean build
``` bash
make clean
```
This simply recusively deletes all the folders from build and below
``` makefile
clean:
	rm -rf $(BUILD_DIR)
```
