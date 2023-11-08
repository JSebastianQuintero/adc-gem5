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


ADD X5, XZR,XZR 					// inicializo i=0 x5=i
SCVTF D10, X10 						// Convierto alpha en punto flotante 

loop3:
    SUB X6, X0, X5
    CBZ X6, end 					// Veo si sigue cumpliendo i<N

	// Cargo X[i] y Y[i] en x12 y x13
	LDUR d12,[X2] 				
    LDUR d13,[X3]					

	// alpha * X[i] + Y[i]
    FMUL D7, D10, D12 				
    FADD D7, D7, D13 
	
	// Guardamos en Z[i] 
    STUR d7, [X4]				
    ADD X5, X5, #1 					// Incremento i
    //LSL X2, X5, 3
    //LSL X3, X5, 3
    //LSL X4, X5, 3
    B loop3
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
