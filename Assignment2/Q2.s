# given n, k find the sum of factorials of all fibonacci numbers upto n and return sum % k by taking modulo in each step
# The number n and k will be stored in register %rbx and %rcx respectively
# Store the final answer in %rdx
# Ensure that overflow doesn’t occur by taking appropriate modulo operations at each stage.
# As the problem involves multiple repeated operations, it is suggested to write procedures for the different operations.
# 1 and 2 have to be taken as first two fibonacci numbers
.global _start

_start:
    mov $5, %rbx # store n in %rbx
    mov $4, %rcx # store k in %rcx
    mov $0, %rdx
    cmp $0, %rbx # checking if n==0
    je exit
    mov $1, %r15 # keep storing values of final answer here and finally update %rdx with this value at the end of the program
    mov $1, %rdi
    mov $1, %rsi
    call fibonacci
    mov %r15, %rdx # store final answer here
    jmp exit
exit:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
fibonacci:
    mov %rsi, %r8 # temp variable r8
    add %rdi, %rsi
    mov %r8, %rdi # these three steps effectively transformed (a, b) ---> (b, a+b) : (%rdi, %rsi)
    mov %rbx, %r10 # temp variable
    cmp %rsi, %r10
    jl end
    push %rdi
    push %rsi
    # Now we need to calculate factorial of %rsi
    mov %rsi, %rdi # making a+b as first arguement for factorial
    call factorial # we get the return value from factorial of %rsi in %rax 
    pop %rsi
    pop %rdi
    add %rax, %r15
    mov %r15, %rax
    mov $0, %rdx
    idiv %rcx
    mov %rdx, %r15 # we know that %rdx stores reminder i.e. (a+b)%k 
    call fibonacci
    ret
factorial:
    cmp $1, %rdi
    je end
    push %rdi
    sub $1, %rdi
    call factorial
    pop %rdi
    imul %rax, %rdi
    mov %rdi, %rax
    mov $0, %rdx
    idiv %rcx
    mov %rdx, %rax
    ret

end:
    mov $1, %rax # this stores the final answer for factorial of a given number
    ret

