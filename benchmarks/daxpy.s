	.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .dword 2      // scalar value
	
	.bss 
	X: .zero  32768        // vector X(4096)*8
	Y: .zero  32768        // Vector Y(4096)*8
	Z: .zero  32768        // Vector Y(4096)*8

	.arch armv8-a
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	x1, 0
	mov	x0, 0
	bl	m5_dump_stats

	ldr     x0, N
	ldr     x10, =Alpha
	ldr     x2, =X
	ldr     x3, =Y
	ldr     x4, =Z

//---------------------- CODE HERE ------------------------------------


ADD X5, XZR, XZR 					// initialize i=0 x5=i
SCVTF D10, X10 						// convert alpha to float point 

loop:
	// Load X[i],Y[i] to x12,x13 respectively
	LDUR D12,[X2] 				
    LDUR D13,[X3]					
	
	// alpha * X[i] + Y[i]
    FMUL D7, D10, D12 				
    FADD D7, D7, D13 

	// Load X[i+1],Y[i+1] to x12,x13 respectively
	LDUR D12,[X2,#8] 				
    LDUR D13,[X3,#8]

	// alpha * X[i+1] + Y[i+1]
    FMUL D8, D10, D12 				
    FADD D8, D8, D13 

	// Load X[i+2],Y[i+2] to x12,x13 respectively
	LDUR D12,[X2,#16] 				
    LDUR D13,[X3,#16]

	// alpha * X[i+2] + Y[i+2]
    FMUL D9, D10, D12 				
    FADD D9, D9, D13 

	// Load X[i+3],Y[i+3] to x12,x13 respectively
	LDUR D12,[X2,#24] 				
    LDUR D13,[X3,#24]

	// alpha * X[i+3] + Y[i+3]
    FMUL D11, D10, D12 				
    FADD D11, D11, D13 

	// Load result to Z[i] 
    STUR D7, [X4]
	// Load result to Z[i+1] 
    STUR D8, [X4,#8]	
	// Load result to Z[i+2] 
    STUR D9, [X4,#16]	
	// Load result to Z[i+3] 
    STUR D11, [X4,#24]		

// ----
	// Index increment				
    ADD X5, X5, #4 // i++
	ADD X2, X2, #24 
	ADD X3, X3, #24 
	ADD X4, X4, #24

	// loop condition
	CMP X5, X0
    blt loop
end:

//---------------------- END CODE -------------------------------------

	mov 	x0, 0
	mov 	x1, 0
	bl	m5_dump_stats
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
