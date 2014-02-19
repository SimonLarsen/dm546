registers_form:
	.string	"eax: 0x%08X, ebx: 0x%08X, ecx: 0x%08X, edx: 0x%08X, esi: 0x%08X, edi: 0x%08X\n"

.text
.globl main

debug:
	pushl	%ebp
	movl	%esp, %ebp

	# Push all general purpose registers
	pushl	%edi
	pushl	%esi
	pushl	%edx
	pushl	%ecx
	pushl	%ebx
	pushl	%eax

	pushl	$registers_form
	call printf
	addl	$4, %esp # Remove form string from stack

	# Pop registers in reverse order
	popl	%eax
	popl	%ebx
	popl	%ecx
	popl	%edx
	popl	%esi
	popl	%edi

	movl	%ebp, %esp
	popl	%ebp

	ret

main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebx
	pushl	%esi
	pushl	%edi

	movl	$0xDEADBEEF, %eax
	movl	$0xDAD, %ebx
	movl	$0xFED, %ecx
	movl	$0xABBA, %edx

	call	debug

	popl	%edi
	popl	%esi
	popl	%ebx

	movl	%ebp, %esp
	popl	%ebp

	ret
