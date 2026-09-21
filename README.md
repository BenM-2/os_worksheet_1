# Add in Assembly


# Task 1


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

letters provide an overflow of some sort 
![alt text](image-1.png)


# Task 2


For Testing Task 2 to check if all the loops where working correctly i used
``` bash
make task_2 && ./build/exec/task_2 > out.txt 
```
This command builds task 2, runs it and pipes all outputs to out.txt overwriting all previous contents
This allowed for me to see how many times the welcome message was printed

