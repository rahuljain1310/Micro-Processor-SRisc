 .main:
	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12	@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7	@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11  @ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   @ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3   @ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  @ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0          @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 5	@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3
	
	
 	@ ADD YOUR CODE HERE 
	mov r3,r0
	mov r9,sp
	call .quicksort

	.end:
		b .end

.swap:
	ld r7,[r5]
	st r8,[r5]
	st r7,[r6]
	add r5,r5,4
	b .swapret

.iterate:
	ld r8,[r6]
	cmp r2,r8
	bgt .swap
	.swapret:
	add r6,r6,4
	cmp r4,r6
	bgt .iterate
	ld r7,[r5]
	st r2,[r5]
	st r7,[r4]
	b .partitionret

.partition:
  ld r2,[r4] 
  mov r5,r3
  mov r6,r3
  b .iterate

.quicksort:
	@ ADD YOUR CODE HERE

	@Base Case
	cmp r3,r4
	bgt .returnqs
	beq .returnqs
	
  @ Allocate Stack Memory And Save Pointer
  add r9,r9,16
  st ra,[r9]
	
  @ Get pivot r5; lo = r3, hi = r4
  b .partition 
	.partitionret:

  @ Store Parameter Right Segment Recursion
	add r5,r5,4
	st r5,4[r9]
	st r4,8[r9]

  @ Recursion on Left Segment
	sub r4,r5,8
  call .quicksort

  @ Recursion on Right Segment
  ld r3,4[r9]
  ld r4,8[r9]
	call .quicksort

  @ Deallocate Memory And Restore Return
  ld ra,[r9]
  sub r9,r9,16

	.returnqs:

  ret


