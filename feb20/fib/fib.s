form:
	.string	"%d\n"

fib:					# fib(n)
	pushl	%ebp
	movl	%esp,%ebp

	pushl	%ebx
	pushl	%esi
	pushl	%edi

	cmpl	$1, 8(%ebp)	# Jump to done if n <= 1
	jle		.basecase

	movl	8(%ebp), %ebx
	movl	%ebx, %eax

	addl	$-1, %eax	# eax = n-1
	pushl	%eax
	call	fib			# Call fib(n-1)
	addl	$4, %esp
	movl	%eax, %edi	# edi = fib(n-1)

	movl	%ebx, %eax
	addl	$-2, %eax	# eax = n-2
	pushl	%eax
	call	fib			# Call fib(n-2)
	addl	$4, %esp
	addl	%edi, %eax	# eax = fib(n-1)+fib(n-2)
	jmp		.done

.basecase:
	movl	8(%ebp), %eax

.done:
	popl	%edi
	popl	%esi
	popl	%ebx

	movl	%ebp, %esp
	popl	%ebp
	ret

.globl main
main:
	pushl	%ebp
	movl	%esp,%ebp

	pushl	%ebx
	pushl	%esi
	pushl	%edi
					
	pushl	$13
	call	fib
	addl	$4,%esp
					
	pushl	%eax
	pushl	$form
	call	printf

	addl	$8,%esp

	popl	%edi
	popl	%esi
	popl	%ebx

	movl	%ebp, %esp
	popl	%ebp
	ret
