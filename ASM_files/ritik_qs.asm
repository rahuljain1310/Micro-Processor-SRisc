 .main:
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
	mov r2, 0          @ Starting address of the array
	mov r3, 5	@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3
	div r3, r3, 4 @ r2 is the lower bound of my array and r3 is the upper bound, i.e. r2=0, r3=n-1
	mov r5, 0 @ Initialising the pivot to 0'th index
	call .quicksort
	.terminate:
			b .terminate 
.quicksort:
	cmp r2,r3
	bgt .continue 						@ return if low>high
	add sp, sp, 12 						@ stores return address, low, high
	st ra, [sp]
	st r2, 4[sp]
	st r3, 8[sp]
	call .pivot 						@ pivot index for this array is updated
	sub r3, r5, 1
	call .quicksort 					@ calling quicksort from low to pivot-1
	ld r3, 8[sp]
	add r2, r5, 1
	call .quicksort 					@ calling quicksort from pivot+1 to high
	ld r2, 4[sp]
	ld ra, [sp]
	sub sp, sp, 12 						@ restoring the stack pointer
	ret
.pivot: 
	cmp r2, r3
	beq .continue 						@ return in case of a single element
	mov r5, r2 							@ Initialising the pivot element to be low of the array
	add r4, r2, 1
	.loop: 								@ Used for getting the correct index of the pivot element
		mul r6, r5, 4
		add r6, r0, r6
		ld r7, [r6] 					@ arr[pivot]
		mul r8, r4, 4
		add r8, r0, r8
		ld r9, [r8] 					@ arr[i]
		cmp r7, r9
		beq .incr 						@ do nothing if they are equal
		bgt .swap 						@ swaps if arr[pivot]>arr[i]
		.fwd:
		b .incr
.incr: 
	cmp r4, r3
	beq .back 							@ return if n'th element is reached
	add r4, r4, 1
	b .loop		
.swap: 
	add r10, r5, 1
	mul r10, r10, 4
	add r10, r0, r10
	ld r11, [r10] 						@ arr[pivot+1]
	st r9, [r10]
	st r11,[r8]
	st r9, [r6]
	st r7, [r10]
	add r5, r5, 1
	b .fwd 								@ return to the loop
.back:
	ret
.continue: 								@ set pivot to low in base case and return
	mov r5,r2
	ret
 