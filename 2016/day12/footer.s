.global _start

.text

_start:
call run
mov %rax, %rdi
call puti
mov $10, %rdi
call putc

xor %rax, %rax
xor %rbx, %rbx
mov $1, %rcx
xor %rdx, %rdx

call run
mov %rax, %rdi
call puti
mov $10, %rdi
call putc

mov $60, %rax
syscall


# fd in %rdi
# buf* in %rsi
# count in $rdx
write:
    mov $1, %rax
    syscall
    ret

# print character from %rdi
# to stdout
putc:
    mov %rdi, wbuf
    mov $0, %rdi
    mov $wbuf, %rsi
    mov $1, %rdx
    call write
    ret

# num in %rdi
puti:
    xor %rsi, %rsi
    mov %rdi, %rax
    xor %rdx, %rdx
    mov $10, %r11
    div %r11
    # quotient in %rax
    # remainder in %rdx
    cmp $0, %rdi
    jge 1f
    push %rdi
    mov $'-', %rdi
    call putc
    pop %rdi
    neg %rdi
    call puti
    ret
1:
    cmp $9, %rdi
    jle 2f 
    push %rdx
    mov %rax, %rdi
    call puti
    pop %rdx
2:
    mov %edx, %esi # remainder
    add $'0', %edx
    mov %edx, %edi
    call putc
10:
    ret

.data
wbuf: .quad 0
