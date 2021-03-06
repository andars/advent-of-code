.data
ifn: .asciz "input.txt"
.equ x, %r8
.equ y, %r9
.equ vx, %r14
.equ vy, %r15
.equ acc, %r10
.equ index, %r13
.equ current, %r12b
buf: .fill 1024
wbuf: .quad 0

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

# fd in %rdi
# buf* in %rsi
# count in %rdx
read:
    xor %rax, %rax
    syscall
    ret

# fd in %rdi
# buf* in %rsi
read_file:
    mov $1024, %rdx
    call read
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

advance:
    cmp $'R', current
    jne 1f
    # R detected
    neg vx
    xchg vx, vy
    jmp 10f
1:
    cmp $'L', current
    jne 2f
    # L detected
    neg vy
    xchg vx, vy
    jmp 10f
2:
    cmp $' ', current 
    jne 3f
    # space detected
    jmp 10f

3:
    cmp $',', current 
    je 4f
    cmp $'\n', current 
    je 4f
    jmp 5f
4:
    # newline or comma detected
    mov vx, %rax
    imul acc
    add %rax, x
    mov vy, %rax
    imul acc 
    add %rax, y
    # reset accumulator
    xor acc, acc
    jmp 10f
5:
    # digit
    sub $'0', current
    imul $10, acc, acc
    movsx current, %rax
    add %rax, acc
10:
    ret
     
.globl _start
_start:
    inc vy
    xor index, index
    mov $ifn, %rdi
    call open_read # open file, fd in %rax
    mov %rax, %rdi
    mov $buf, %rsi
    call read_file

loop:
    movb buf(index), current
    test current, current
    js end

    call advance

    inc index
    jmp loop
end:
    mov x, %rsi
    neg x 
    cmovl %rsi, x 

    mov y, %rsi
    neg y 
    cmovl %rsi, y 

    add x, y 
    mov y, %rdi
    call puti
    mov $10, %rdi
    call putc
    mov $0, %rdi
    call exit
    
