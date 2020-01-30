# Compile using gcc -g -nostdlib Fibonacci.s
# Calculate the i for which x divides i! for smallest possible i
.global _start

.text

_start:
        # mov $23, %r8         # store value of x in rax
        mov %r8, %rax
        mov %rax, %r8        # take a copy of rax int r8   
        mov $1, %r9          # stores initial value of i(iterator) in r9
        mov %r9, %rax        # Inorder to perform division i will store 'i' in rax temporarily 
        mov $0, %r10        # another copy of i stored in r10
        # Here r10 stores consecutive values of i while r9 stores i!
loop:
    mov $0, %rdx
    add $1, %r10              # Increment value of i
    imul %r10, %r9
    mov %r9, %rax
    idivq %r8
   # mov %rbx, %rcx           # temp = b  
   # add %rax, %rbx           # b = a + b
   # movq %rbx, %r8
   # mov %rcx, %rax           # a = temp
   # dec %rdx                 # n -= 1
    cmp $0, %rdx             # Compare value of n and 0 
    jne loop                 # if (n > 0), continue the loop 
    mov %r10, %rdi            # rdi is storing the final answer
    mov %rdi, %r11            # absolute final answer is stored here for evaluation
    mov %r8, %rax
exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall


