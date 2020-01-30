.global _start

.text

_start:
    mov $5, %r8   # a is initially stored in r8
    mov $3, %r9   # b is initially stored in r9
    mov $6, %r10  # n is initially stored in r10
    mov %r8, %rax  # a copy of a in register rax which will facilitate the usage of rax
    mov $0, %rdx
    idivq %r10     # step : a%n will now be stored in %rdx
    mov %rdx, %r8  # updating value of a in r8 to a%n
    mov $1, %r15   # the varible 'acc' that's mentioned in the code which is actively used in producing the final result
    mov $2, %r14   # storing value 2 for caluculating b/2
loop :
    label :
        mov %r9, %r12 # temporary storage of b
        and $1, %r12  # In order to check if b is odd
        cmp $0, %r12
        je simple
        b_odd :
            imul %r8, %r15     # here we executed acc=acc*a
            mov %r15, %rax     # moved a copy of acc to rax( for division to obtain reminder (modulo))
            mov $0, %rdx
            idivq %r10         # Now %rdx stores (acc*a)mod(n)
            mov %rdx, %r15     # updating acc i.e r12
        simple :
            mov %r9, %rax
            mov $0, %rdx
            idivq %r14          # This step and it's predecessor are used to perform b/2
            mov %rax, %r9     # b is updated to b/2
            mov %r8, %rax     # a copy of a in rax
            imul %r8, %rax    # in this step a is updated to a*a in rax
            mov $0, %rdx
            idivq %r10         # now value of a = (a*a)mod(n) is in rdx
            mov %rdx, %r8     # Finally a is updated to (a*a)%n
            cmp $0, %r9
            jne loop
    mov %r15, %rdi              # final answer is in rdi
    mov %rdi, %r11              # absolute final answer is in r11
exit:
        mov     $60, %rax               # system call 60 is exit
        xor     %rdi, %rdi              # we want return code 0
        syscall
