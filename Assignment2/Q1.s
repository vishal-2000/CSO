# A and B will be stored in %rbx, %rcx
# Conditions
# 1. A must be divisible by x
# 2. X, B must be co-prime
# 3. X must be maximum
# 4. Final answer must be stored in %rdx

.global _start
# Here comes the main function
_start:
    mov $10107, %rbx # storing A initially in rbx
    mov $8, %rcx # storing A initially in rbx
    mov %rbx, %r8 # temporary storage for A and actually stores and checks for X
    # mov %rcx, r # temporary storage for B
    mov $0, %r10 # iterator
    jmp loop1
    call exit
loop1:
    add $1, %r10 # increment iterator
    # Now let's check divisibility
    mov $0, %rdx
    mov %rbx, %rax # These two move operations are for idiv
    idiv %r10
    cmp $0, %rdx
    je label5
    jmp loop1
label5:
    mov %rax, %rdi
    mov %rax, %r8
    mov %rcx, %rsi
    call gcd
    cmp $1, %rax
    jne loop1 # If gcd!=1 then loop otherwise return with answer
    mov %r8, %r15 # store answer value of X here in %r8
    mov $0, %rdx
    mov $0, %r14 # stores temporarily the value of sum of digits
    mov $10, %r13
    jmp preexit
# this preexit is to calculate sum of digits
preexit:
    mov %r15, %rax
    mov $0, %rdx
    idiv %r13
    add %rdx, %r14
    mov %r14, %rdx
    cmp $0, %rax
    je exit
    mov %rax, %r15
    jmp preexit
exit:
    mov $60, %rax
    xor %rdi, %rdi
    syscall


# Function to check the gcd of arguements listed in X = %rdi, B = %rsi
gcd:
    cmp $0, %rdi
    je label1 # if %rdi == 0 this label returns %rsi as gcd
    cmp $0, %rsi
    je label2 # if %rsi == 0 this label returns %rdi as gcd
    cmp %rsi, %rdi
    jge label3 # if %rdi >= 0 this label calls gcd(%rdi - %rsi, %rsi)
    # cmp
    jmp label4 # if %rdi >= 0 this label calls gcd(%rdi, %rsi - %rdi)
    label0:
        ret

label1:
    movq %rsi, %rax
    jmp label0
    # ret
label2:
    movq %rdi, %rax
    jmp label0
    # ret
label3:
    sub %rsi, %rdi
    call gcd
    jmp label0
    # ret
label4:
    sub %rdi, %rsi
    call gcd 
    jmp label0
    # ret  

# ###################################################################################################################### Remove below part
 #   add $1, %r10 # increment iterator
  #  jmp label6
   # mov %r8, %rdi
#    mov %rcx, %rsi
 #   call gcd
  #  cmp $1, %rax
   # je label5
    # jmp label6
# label5:
  #  mov %r8, %rax 
   # ret
# label6:
  #  mov $0, %rdx
   # mov %rbx, %rax # These two move operations are for idiv
   # idiv %r10
#    cmp $0, %rdx
 #   je label7
    # otherwise
  #  jmp loop1
# label7:
