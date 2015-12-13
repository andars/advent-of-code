.global main 

.data
lights: .space 1000000, 0
message: .asciz "Hello, world\n"
format1: .asciz "%s"
format2: .asciz "%d,%d through %d,%d"
test: .asciz "turn"

str_change: .asciz "detected turn (on/off)!"

streq:
    push %rbp
    mov %rsp, %rbp
    mov $1, %rax
    
streq_loop:
    movb (%rsi), %cl
    cmpb (%rdi), %cl
    jne streq_diff
    inc %rdi
    inc %rsi
    cmpb $0, (%rdi)
    je streq_end
    cmpb $0, (%rsi)
    je streq_end
    jmp streq_loop

streq_diff:
    xor %rax, %rax
streq_end:
    leave
    ret

.text
main:
    push %rbp
    mov %rsp, %rbp
    sub $0x10, %rsp
    #-8(rbp): 5 char buffer
    #-8(rbp): 

    #mov %rbp, %rdi
    xor %rax, %rax
    xor %rdi, %rdi # stdin
    lea -0x10(%rbp), %rsi # points to the buffer
    mov $4, %rdx # length 4
    syscall

    movb $0, -12(%rbp)

    lea -0x10(%rbp), %rdi
    mov $test, %rsi
    call streq

    cmp $0, %rax
    je main_next
    mov $str_change, %rdi
    call puts

main_next:
    lea -0x10(%rbp), %rdi # points to the buffer
    call puts

    ;mov $10, %ebx
#main_loop:
#    mov $message, %rdi
#    call puts
#    sub $1, %ebx
#    jne main_loop

    leave
    ret    
