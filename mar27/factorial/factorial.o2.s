factorial:
	movl	4(%esp), %edx	# edx = n
	movl	$1, %eax		# eax = 1
	testl	%edx, %edx		# if edx == 0 return 1;
	je	.L2
.L3:						# while edx != 0
	imull	%edx, %eax		# eax = eax * edx
	subl	$1, %edx		# edx = edx-1
	jne	.L3					# jump if (edx-1) != 0
.L2:
	rep ret					# return eax

.LC0:
	.string	"%d\n"

.globl	main
.type	main, @function
main:
	movl	$1, %edx
	movl	$7, %eax
.L11:
	imull	%eax, %edx
	subl	$1, %eax
	jne	.L11
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$16, %esp

	movl	%edx, 4(%esp)
	movl	$.LC0, (%esp)
	call	printf

	xorl	%eax, %eax

	leave
	ret
