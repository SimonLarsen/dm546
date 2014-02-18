# printf format strings
num:
	.string "%d "
newline:
	.string "\n"

.text
.globl main

printarray:
	pushl	%ebp
	movl	%esp, %ebp

	# for i = 0 to 8
	movl	$0, %ebx
.printloop:
	pushl	array(,%ebx,4) # push board[ebx*4]
	pushl	$num		   # push "%d "
	call	printf
	addl	$8, %esp

	incl	%ebx
	cmpl	$9, %ebx
	jne		.printloop
# end .printloop

	# Print newline
	pushl	$newline
	call	printf
	addl	$4, %esp

	movl	%ebp, %esp
	popl	%ebp
	ret

sortarray:
	pushl	%ebp
	movl	%esp, %ebp
	
	movl	$0, %eax # outer loop variable
	# ebx = inner loop variable
	# ecx = min index 
	# edi = min value

.outerloop:
	movl	%eax, %ebx 
	incl	%ebx		# ebx = eax + 1
	movl	%eax, %ecx	# min = eax
	movl	array(,%ecx,4), %edi # edi = array[ecx]

.innerloop:
	cmpl	%edi, array(, %ebx, 4)
	jg		.notless
	movl	%ebx, %ecx
	movl	array(,%ecx,4), %edi

.notless:
	incl	%ebx
	cmpl	$9, %ebx
	jl		.innerloop
# end .innerloop

	# swap array[eax] and array[ecx]
	movl	array(,%eax,4), %esi # esi = array[eax]
	movl	%edi, array(,%eax,4)
	movl	%esi, array(,%ecx,4)

	incl	%eax
	cmpl	$8, %eax
	jne		.outerloop
# end .outerloop

	movl 	%ebp, %esp
	popl	%ebp

	ret

main:
	# Create new stack frame
	pushl	%ebp
	movl	%esp, %ebp

	# Save caller-save registers
	pushl	%ebx
	pushl	%esi
	pushl	%edi

	# Call sorting function
	call	sortarray

	# Print array
	call	printarray

	# Restore caller save registers
	popl	%edi
	popl	%esi
	popl	%ebx

	# Restore old stack frame
	movl	%ebp, %esp
	popl	%ebp
	ret

.data

array:
	.int	7,2,5,6,9,1,3,4,8
