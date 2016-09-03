; /usr/local/bin/nasm -f macho 32.asm && ld -macosx_version_min 10.7.0 -o 32 32.o && ./32

global start

section .text
start:
    push    dword msg.len
    push    dword msg
    push    dword 1 ; file descriptor value
    mov     eax, 4 ; system call number for write
    sub     esp, 4 ; OS X (and BSD) system calls needs "extra space" on stack
    int     0x80 ; make the actual system call
    ; clean up the stack
    add     esp, 16 ; 3 args * 4 bytes/arg + 4 bytes extra space = 16 bytes

    push    dword 0 ; exit status returned to the operating system
    mov     eax, 1 ; system call number for exit
    sub     esp, 4 ; OS X (and BSD) system calls needs "extra space" on stack
    int     0x80 ; make the system call

section .data

msg:    db      "Hello, world!", 10
.len:   equ     $ - msg
