factorial:
	movl	4(%esp), %edx	# edx = n
	movl	$1, %eax		# eax = 1
	testl	%edx, %edx		# is edx == 0?
.L3:
	imull	%edx, %eax		# eax = eax * edx
	subl	$1, %edx		# edx = edx-1
	jne	.L3					# repeat if edx != 0
.L2:
	rep ret

.LC0:
	.string	"%d\n"

.globl	main
main:
	pushl	%ebp
	movl	%esp, %ebp

	andl	$-16, %esp
	subl	$16, %esp

	movl	$5040, 4(%esp)	# put precomputed factorial(7) = 5040 on stack
	movl	$.LC0, (%esp)	# MAGIC
	call	printf

	xorl	%eax, %eax

	leave
	ret
