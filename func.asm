include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib

.code

FindSyscallNum PROC



xor rsi, rsi
xor rdi, rdi

mov rsi, 00B8D18B4Ch

mov edi, [rcx]

mov r8, 1
cmp rsi, rdi
jne HalosGateUp

xor r8, r8

mov rax, [rcx+4]
mov [rdx], rax

mov rax, 0 
ret

HalosGateUp:
mov rax, 32
mov r12, rdx
mul r8
mov rdx, r12
xor r12, r12

mov r9, rcx
add r9, rax
mov edi, [r9]
inc r8
cmp rsi, rdi
jne HalosGateDown

mov rax, [r9+4] 
mov r11, r8
sub r11, 1
sub rax, r11
mov [rdx], rax
mov eax, 0
ret

HalosGateDown:
mov rax, 32
dec r8

mov r12, rdx
mul r8
mov rdx, r12
xor r12, r12
inc r8

mov r9, rcx
sub r9, rax
mov edi, [r9]

cmp rsi, rdi 
jne HalosGateUp

mov rax, [r9+4]
dec r8
add rax, r8
inc r8
mov [rdx], rax
mov eax, 0
ret


FindSyscallNum ENDP


Prepare PROC

;1st Argument: RCX this is syscall number

;2nd Argument: RDX function address

;3rd Argument: R8 unused

;4th Argument: R9 unused

xor r11, r11
mov r11d, ecx

add rdx, 12h

xor r15, r15
xor r14, r14

mov r15w, [rdx]
mov r14w, 050Fh

cmp r15w, r14w
jne findsyscall

xor r15, r15
xor r14, r14

mov r12, rdx
mov rax, 0
ret

findsyscall:
xor r15, r15
add rdx, 1
mov r15w, [rdx]

cmp r15w, r14w
jne findsyscall

xor r15, r15
xor r14, r14

mov r12, rdx
mov rax, 0
ret

Prepare ENDP

indirectSyscall PROC

; arguments are just the arguments to the syscall

mov r10, rcx
mov eax, r11d
jmp r12
ret

indirectSyscall ENDP

end