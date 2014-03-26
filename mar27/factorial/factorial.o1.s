factorial:
	pushl	%ebx
	subl	$24, %esp
	movl	32(%esp), %ebx
	movl	$1, %eax
	testl	%ebx, %ebx		# is n == 0?
	je	.L2	
	leal	-1(%ebx), %eax	# subtract 1 from ebx (n-1)
	movl	%eax, (%esp)
	call	factorial
	imull	%ebx, %eax		# calculate n * factorial(n-1)
.L2:
	addl	$24, %esp
	popl	%ebx
	ret						# return eax = 1

.LC0:
	.string	"%d\n"			# printf format string

.text
.globl	main
.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp

	andl	$-16, %esp		# Allocate 4 words on stack
	subl	$16, %esp		# Allocate 4 more words?

	movl	$7, (%esp)		# Call factorial(7)
	call	factorial

	movl	%eax, 4(%esp)	# move result to stack
	movl	$.LC0, (%esp)	# move format string to stack
	call	printf			# print result

	movl	$0, %eax		# return 0

	leave
	ret
