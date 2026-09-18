.section .data

msg1:
    .ascii "Enter first string: "
msg1_len = . - msg1

msg2:
    .ascii "Enter second string: "
msg2_len = . - msg2

msg3:
    .ascii "Hamming distance: "
msg3_len = . - msg3

newline:
    .byte 10

.section .bss

.lcomm str1, 256
.lcomm str2, 256
.lcomm num, 20

.section .text
.global _start

_start:

    # print first prompt
    mov $1, %rax
    mov $1, %rdi
    lea msg1(%rip), %rsi
    mov $msg1_len, %rdx
    syscall

    # read first string
    mov $0, %rax
    mov $0, %rdi
    lea str1(%rip), %rsi
    mov $255, %rdx
    syscall

    mov %rax, %r12
    dec %r12

    # print second prompt
    mov $1, %rax
    mov $1, %rdi
    lea msg2(%rip), %rsi
    mov $msg2_len, %rdx
    syscall

    # read second string
    mov $0, %rax
    mov $0, %rdi
    lea str2(%rip), %rsi
    mov $255, %rdx
    syscall

    mov %rax, %r13
    dec %r13

    # find shorter length
    mov %r12, %rcx
    cmp %r13, %r12
    jle start_compare
    mov %r13, %rcx

start_compare:

    xor %rbx, %rbx
    xor %r8, %r8

compare:

    cmp %rcx, %r8
    jge print_answer

    lea str1(%rip), %rsi
    mov (%rsi,%r8,1), %al

    lea str2(%rip), %rsi
    mov (%rsi,%r8,1), %dl

    xor %dl, %al

    mov $8, %r9

count_bits:

    test $1, %al
    jz skip

    inc %rbx

skip:

    shr $1, %al
    dec %r9

    cmp $0, %r9
    jne count_bits

    inc %r8
    jmp compare

print_answer:

    # print result message
    mov $1, %rax
    mov $1, %rdi
    lea msg3(%rip), %rsi
    mov $msg3_len, %rdx
    syscall

    # convert number to text
    mov %rbx, %rax
    lea num(%rip), %rsi
    add $19, %rsi

    mov $10, %r10
    xor %rcx, %rcx

convert:

    xor %rdx, %rdx
    div %r10

    add $'0', %dl

    dec %rsi
    mov %dl, (%rsi)

    inc %rcx

    cmp $0, %rax
    jne convert

    # print answer
    mov $1, %rax
    mov $1, %rdi
    mov %rcx, %rdx
    syscall

    # print newline
    mov $1, %rax
    mov $1, %rdi
    lea newline(%rip), %rsi
    mov $1, %rdx
    syscall

    # exit
    mov $60, %rax
    mov $0, %rdi
    syscall
    