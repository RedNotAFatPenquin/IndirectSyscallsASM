# IndirectSyscallsASM
100% asm indirect syscalls to evade edr hooks

usage

```cpp
extern "C" {
    BOOL FindSyscallNum(FARPROC FunctionAddress, DWORD* syscallNumber);
    BOOL Prepare(DWORD syscallNumber, FARPROC FunctionAddress);
    NTSTATUS indirectSyscall(...);
}
```

add this to the top 

example using it as NtTerminateProcess
```cpp
    FindSyscallNum(functionaddress, &syscallnum);
    
    std::cout << "Syscallnumber: " << std::hex << syscallnum << '\n';

    HANDLE Process = OpenProcess(PROCESS_ALL_ACCESS, TRUE, 15200);

    Prepare(syscallnum, functionaddress); // DO NOT HAVE ANY CHECKS INBETWEEN THESE 2 AS IT WILL FUCK THINGS UP THEY NEED TO BE NEXT TO EACH OTHER
    indirectSyscall(Process, 0xDEADBEEF);

```

Flaw

it moves 32 down which could be diffrent if the ntdll is hooked lol
