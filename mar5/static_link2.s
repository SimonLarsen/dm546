# Implementation of the following program using static link
#
# var x:int;
#
# func a() : int
#     func b() : int
#         return c();
#     end b
#
#     return b();
# end a
#
# func c() : int
#     write x;
# end c
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

	movl	8(%ebp), %eax	# Follow static link
	movl	8(%eax), %eax	# Copy static link into eax

	pushl	%eax			# Push static link
	call	c
	addl	$4, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret

c: 
	pushl	%ebp
	movl	%esp, %ebp

	movl	8(%ebp), %eax	# Follow static link
	movl	-4(%eax), %eax	# Retrieve x from stack

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
