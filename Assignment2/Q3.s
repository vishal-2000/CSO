# Given an array of integers we need to find for each element a nearest shorter integer to its left 
# The number n will be stored in register %rbx.
# The base address of the input array will be stored in register %rcx.
# The base address of the output array will be stored in register %rdx.
# Consider the heights to be 8-byte (64-bits) integer. Use move suffixes and store the answers in memory accordingly.
.global _start
_start:
    movq $6, %rbx # no of elements in the array
    addingElements:
        leaq -8(%rsp), %rcx # iinitialising base for input array
        pushq $1
        pushq $2
        pushq $3
        pushq $2
        pushq $3
        pushq $2
        leaq -16(%rsp), %rdx
        leaq -76(%rsp), %rsp
        movq %rsp, %rsi
    mov %rcx, %rbp # i store base address of rcx in rbp so that i can iterate through elements using rbp
    # remember i use a stack with %rsp pointing to it while implementing this solution
    # initialise iterator for outer loop
    mov $0, %r10 # r10 contains iterator for outer loop
    mov %rbx, %r11 # temp value store of n (never change this register anywhere in te program)
    jmp outerloop
outerloop: 
    mov %rsp, %r8 # r8 is temp variable
    # leaq -8(%rcx), %r15 # temp
    movq %rsi, %r15 # temp # removed -8 in debugging and replaced leaq
    cmp %r15, %r8
    je afterInnerLoop
    mov $-1, %rax  # used to store (-(iterator)) usefull for stack manipulation
    imul %r10, %rax
    mov (%rbp, %rax, 8), %r8 # temp variable always used for all comparisions in this program
    cmp (%rsp), %r8 # s.top()>= arr[i] then go into inner loop, s.top==(%rsp), %r8 == arr[i]
    jg afterInnerLoop
    innerloop: # if !s.empty() && s.top() >= arr[i] then jump into inner loop
        popq %r11 # discard value in %r11
        mov %rsp, %r8 # r8 is temp variable
        # cmp -8(%rcx), %r8
        movq %rsi, %r15 # removed -8 in debugging and replaced leaq
        cmp %r15, %r8
        je afterInnerLoop
        mov $-1, %rax  # used to store (-(iterator)) usefull for stack manipulation
        imul %r10, %rax
        mov (%rbp, %rax, 8), %r8 # temp variable always used for all comparisions in this program
        cmp (%rsp), %r8 # s.top()>= arr[i] then go into inner loop, s.top==(%rsp), %r8 == arr[i]
        jg afterInnerLoop
        jmp innerloop
    afterInnerLoop:
        mov %rsp, %r8 # r8 is temp variable
        # cmp -8(%rcx), %r8 # check if stack is empty
        movq %rsi, %r15 # temp variable # removed -8 in debugging and replaced leaq
        cmp %r15, %r8 # check if stack is empty
        je empty_stack
        mov $-1, %rax # used to store (-(iterator)) usefull for stack manipulation
        imul %r10, %rax
        movq (%rsp), %r13
        movq %r13, (%rdx, %rax, 8)
        jmp continue
        empty_stack:
            mov $-1, %rax  # used to store (-(iterator)) usefull for stack manipulation
            imul %r10, %rax
            movq $-1, (%rdx, %rax, 8)
            jmp continue
        continue:
            mov $-1, %rax  # used to store (-(iterator)) usefull for stack manipulation
            imul %r10, %rax
            pushq (%rbp, %rax, 8)
            inc %r10
            mov %rbx, %r11
            cmp %r10, %r11
            jg outerloop
exit:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
    

    
