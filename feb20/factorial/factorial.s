form:
	.string	"%d\n"

fac:
						# Next 3 are standard callee begin actions
	pushl %ebp			# Saving base pointer
	movl %esp,%ebp		# Making stack pointer new base pointer
	pushl %ebx			# %ebx is "callee save"
	
	movl 8(%ebp),%eax	# Assigning argument 1 to %eax
	cmpl $1,%eax		# Comparing %eax to the constant 1
	jne else			# Jump to else if not equal
	movl $1,%eax		# Assigning the result (the constant 1) to %eax
	jmp end				# Jump to end
else:
	movl %eax,%ebx		# Assigning %eax to %ebx
	addl $-1,%eax		# Adding -1 to %eax
	
						# Next 1 is caller preparation
	pushl %eax			# Pushing %eax (1. argument)
	call fac			# Automatically pushes return address
						# By convention, return value is in %eax

						# Next 1 is caller's end-of-call duty
	addl $4,%esp		# Popping arguments off stack
	
	movl %eax,%edx		# Assign return value from call to %edx
	imul %edx,%ebx		# %ebx is assigned %edx times %ebx
	movl %ebx,%eax		# Assign to %eax for return
end:
						# Next 4 are standard callee end actions
	popl %ebx			# Restoring "callee save" register
	movl %ebp,%esp		# Restoring stack pointer
	popl %ebp			# Restoring base pointer
	ret					# Return from call

.globl main
main:					# Program starts here
						# Next 5 are standard callee begin actions
	pushl %ebp			# Saving base pointer
	movl %esp,%ebp		# Making stack pointer new base pointer

	pushl %ebx			# %ebx is "callee save"
	pushl %esi			# %esi is "callee save"
	pushl %edi			# %edi is "callee save"

						# Next 1 is caller preparation
	pushl $3			# Pushing the constant 5 (1. argument)
	call fac			# Automatically pushes return address
	addl $4,%esp		# Popping argument off stack
						# By convention, return value is in %eax

						# Next 2 are caller preparation
	pushl %eax			# Pushing %eax (2. argument)
	pushl $form			# Pushing string address (1. argument)
	call printf			# Automatically pushes return address
						# Next 1 is caller's end-of-call duty
	addl $8,%esp		# Popping arguments off stack

						# Next 6 are standard callee end actions
	popl %edi			# Restoring "callee save" register
	popl %esi			# Restoring "callee save" register
	popl %ebx			# Restoring "callee save" register

	movl %ebp,%esp		# Restoring stack pointer
	popl %ebp			# Restoring base pointer
	ret					# Return from call
