# Implementation of the following program using static link
#
# var x:int;
#
# func a() : int
#     func b() : int
#         write x;
#         return 0;
#     end b

#     return b();
# end a
#
# x = 42;
# a();

num:
	.string "%d\n"

.text
.globl main

a:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	%ebp		# Push static link
	call	b
	addl	$4, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret

b:
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %ecx	# Follow static link
	movl	8(%ecx), %ecx	# Follow again
	movl	-4(%ecx), %eax	# Retrieve x from stack

	pushl	%eax
	pushl	$num
	call	printf			# Print x
	addl	$8, %esp
	xorl	%eax, %eax

	movl	%ebp, %esp
	popl	%ebp
	ret

main:
	pushl	%ebp
	movl	%esp, %ebp

	pushl	$42			# Set x = 42
	pushl	%ebp		# Push static link
	call	a
	addl	$8, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret
