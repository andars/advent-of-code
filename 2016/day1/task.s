.globl _start


.data
ifn: .asciz "input.txt"
ifd: .quad 0
x: .quad 0
y: .quad 0
vx: .quad 0
vy: .quad 1
buf: .fill 16
acc: .quad 0

.text
# filename address in %rdi
# flags in %rsi
# mode in %rdi
# fd in %rax
open:
    mov $2, %rax
    syscall
    ret

open_read:
    xor %rsi, %rsi
    xor %rdx, %rdx
    call open
    ret

open_write:
    mov $1, %rsi
    mov $1, %rdx
    call open
    ret


# fd in %rdi
# buf* in %rsi
# count in %rdx
read:
    xor %rax, %rax
    syscall
    ret

# fd in %rdi
# buf* in %rsi
# count in $rdx
write:
    mov $1, %rax
    syscall
    ret

# exit value in %rdi
exit:
    mov $60, %rax
    syscall

getc:
    mov ifd, %rdi
    mov $buf, %rsi
    mov $1, %rdx
    call read
    test %rax, %rax
    jnz 1f
    mov $-1, %rax
    ret
1:    
    mov buf, %rax
    ret

# print character from buf
# to stdout
putc:
    mov $0, %rdi
    mov $buf, %rsi
    mov $1, %rdx
    call write
    ret

# buf* in %rdi
# count in %rsi
puts:
    mov %rsi, %rdx
    mov %rdi, %rsi
    mov $0, %rdi
    call write
    ret

# num in %rdi
puti:
    xor %rsi, %rsi
    mov %rdi, %rax
    xor %rdx, %rdx
    mov $10, %rcx
    div %rcx
    # quotient in %rax
    # remainder in %rcx
    cmp $0, %rdi
    jge 3f
    push %rdi
    movb $'-', buf
    call putc
    pop %rdi
    neg %rdi
    call puti
    ret
3:
    cmp $9, %rdi
    jle 1f 
    push %rdx
    mov %rax, %rdi
    call puti
    pop %rdx
1:
    mov %edx, %esi # remainder
    add $'0', %edx
    mov %edx, buf
    call putc
10:
    ret

advance:
    xor %rax, %rax
    mov buf, %ax
    cmp $'R', %ax
    jne 1f
    # R detected
    mov vx, %r14
    mov vy, %r15
    neg %r14
    mov %r15, vx #  y -> x
    mov %r14, vy # -x -> y
    jmp 10f
1:
    cmp $'L', %ax
    jne 2f
    # L detected
    mov vx, %r14
    mov vy, %r15
    neg %r15
    mov %r15, vx # -y -> x
    mov %r14, vy #  x -> y
    jmp 10f
2:
    cmp $' ', %ax
    jne 3f
    # space detected
    jmp 10f

3:
    cmp $',', %ax
    je 4f
    cmp $'\n', %ax
    je 4f
    jmp 5f
4:
    # newline or comma detected
    mov acc, %rdi
    mov vx, %rax
    imul %rdi
    add %rax, x
    mov vy, %rax
    imul %rdi
    add %rax, y
    # reset accumulator
    xor %rdi, %rdi
    mov %rdi, acc
    # \n
    jmp 10f
    jmp 10f
5:
    # digit
    sub $'0', %ax
    imul $10, acc, %rdi
    add %rax, %rdi
    mov %rdi, acc
10:
    ret
     
_start:
    # open files, store fd's
    mov $ifn, %rdi
    call open_read
    mov %rax, ifd
loop:
    call getc
    test %rax, %rax
    js end
    mov %rax, buf
    call advance

    jmp loop
end:
    movb $'\n', buf
    call putc
    mov buf, %rdi 

10:
    mov x, %rdi
    mov %rdi, %rsi
    neg %rdi
    cmovl %rsi, %rdi
    mov %rdi, %r14
    mov y, %rdi
    mov %rdi, %rsi
    neg %rdi
    cmovl %rsi, %rdi
    mov %rdi, %r15
    add %r14, %r15
    mov %r15, %rdi
    call puti
    movb $10, buf
    call putc
    mov $0, %rdi
    call exit
    
