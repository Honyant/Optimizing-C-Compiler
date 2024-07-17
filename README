# Optimizing Compiler in C

## Overview

This project is a robust compiler built in C, designed to parse and compile a custom programming language into arm64 assembly. The compiler handles a variety of control structures, functions, and expressions.

## Features

- **Function Handling**: Support for defining and invoking functions, with scope and lifetime management.
- **Control Structures**: Implements control flow constructs like `if`, `else`, `while`, and `return`.
- **Operator Overloading**: Extensive support for arithmetic and logical operations, ensuring a rich programming experience.
- **Error Handling**: Comprehensive error reporting that helps trace back to the exact point of failure in the program.

## Getting Started

### Prerequisites

The interpreter is designed to run on Linux systems with GCC installed. Make sure you have the following installed:
- GCC Compiler
- Standard C Library
- Linux environment

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/honyant/Optimizing-C-Compiler.git
   cd Optimizing-C-Compiler
   ```

2. **Compile the Interpreter**:
   ```bash
   make all
   ```

### Usage

To compile a program using the compiler into a binary, use the following command:

```bash
./build/main {path/to/program}
```

### Example

**Input Program:**
```kotlin
fact = fun {
   out = 0
   while (it > 0) {
       out = out + it
       it = it - 1
   }
   return out
}

print fact(16000000)
```

**Output Assembly (decompiled)**
```asm
.data
var_fact: 
   .quad 0
var_it: 
   .quad 0
var_out: 
   .quad 0
var_argc:
   .quad 0
fmtvarString:
   .string "%ld\n"
.align 16
.text
.global _main
_main:
   mov x6, #0
   adrp x1, var_argc@PAGE //set var
   add x1, x1, var_argc@PAGEOFF
   str x0, [x1]
   adrp x0, fun_12@PAGE //load adr
   add x0, x0, fun_12@PAGEOFF
   adrp x1, var_fact@PAGE //store var
   add x1, x1, var_fact@PAGEOFF
   str x0, [x1]
   adrp x0, var_fact@PAGE //load var
   add x0, x0, var_fact@PAGEOFF
   ldr x0, [x0]
   str x0, [sp, #-16]! //save reg to stack
   movz x0, #4096, lsl #0
   movk x0, #24414, lsl #16
   movk x0, #0, lsl #32
   movk x0, #0, lsl #48
   ldr x1, [sp], #16 //load reg from stack
   str x6, [sp, #-16]! //save reg to stack
   mov x6, x0
   blr x1
   ldr x6, [sp], #16 //load reg from stack
   str x6, [sp, #-16]! //save reg to stack
   str x0, [sp, #-16]! //save reg to stack
   str x1, [sp, #-16]! //save reg to stack
   mov x1, x0
   adrp x0, fmtvarString@PAGE //load adr
   add x0, x0, fmtvarString@PAGEOFF
   bl _printf
   mov x0, x1
   ldr x1, [sp], #16 //load reg from stack
   ldr x0, [sp], #16 //load reg from stack
   ldr x6, [sp], #16 //load reg from stack
   mov x0, #0
   bl _exit
fun_12:
   stp x29, x30, [sp, #-16]! //store fp and lr
   mov x29, sp
   movz x0, #0, lsl #0
   movk x0, #0, lsl #16
   movk x0, #0, lsl #32
   movk x0, #0, lsl #48
   adrp x1, var_out@PAGE //store var
   add x1, x1, var_out@PAGEOFF
   str x0, [x1]
.LWHILEEXPR_2_:
   mov x0, x6
   str x0, [sp, #-16]! //save reg to stack
   movz x0, #0, lsl #0
   movk x0, #0, lsl #16
   movk x0, #0, lsl #32
   movk x0, #0, lsl #48
   mov x1, x0
   ldr x0, [sp], #16 //load reg from stack
   cmp x0, x1
   cset w0, hi
   b .LWHILEEND_2_
.LWHILE_2_:
   adrp x0, var_out@PAGE //load var
   add x0, x0, var_out@PAGEOFF
   ldr x0, [x0]
   str x0, [sp, #-16]! //save reg to stack
   mov x0, x6
   mov x1, x0
   ldr x0, [sp], #16 //load reg from stack
   add x0, x0, x1
   adrp x1, var_out@PAGE //store var
   add x1, x1, var_out@PAGEOFF
   str x0, [x1]
   mov x0, x6
   str x0, [sp, #-16]! //save reg to stack
   movz x0, #1, lsl #0
   movk x0, #0, lsl #16
   movk x0, #0, lsl #32
   movk x0, #0, lsl #48
   mov x1, x0
   ldr x0, [sp], #16 //load reg from stack
   sub x0, x0, x1
   mov x6, x0
   b .LWHILEEXPR_2_
.LWHILEEND_2_:
   cbnz x0, .LWHILE_2_
   adrp x0, var_out@PAGE //load var
   add x0, x0, var_out@PAGEOFF
   ldr x0, [x0]
   b fun_12_end
   mov x0, #0
fun_12_end:
   mov sp, x29 //restore fp and lr
   ldp x29, x30, [sp], #16
   ret

```