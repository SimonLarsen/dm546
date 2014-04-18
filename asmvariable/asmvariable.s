.text
form:
	.string "%p\n"

.global main

main:
	push	%ebp
	movl	%esp, %ebp

	# Allocate space
	pushl	$16
	call	malloc
	addl	$4, %esp

	# Move pointer to next variable
	movl	%eax, next

	# Print next pointer
	pushl	next
	pushl	$form
	call	printf
	addl	$8, %esp
	
	leave
	ret

.data
next:
	.long 0
