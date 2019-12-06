.main:
	@ Loading the values as an array into the registers
	mov r0, 0    
  mov r1, 49
  st r1, 0[r0]
  mov r1, 63
  st r1, 4[r0]
  mov r1, 85
  st r1, 8[r0]
  mov r1, 37
  st r1, 12[r0]
  mov r1, 93
  st r1, 16[r0]
  mov r1, 59
  st r1, 20[r0]
  mov r1, 95
  st r1, 24[r0]
  mov r1, 100
  st r1, 28[r0]
  mov r1, 90
  st r1, 32[r0]
  mov r1, 56
  st r1, 36[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0          @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 9	@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3
	
	@ ADD YOUR CODE HERE 
	
  mov r9,sp
	mov r0,r2
	mov r1,r4
	mov r3,r0
	mov r4,r1
	call .mergesort

  .terminate:
    b .terminate

.addArrayr6:      @ If One Array is Finished
  add r9,r9,4     @ Fill the other in the Merge Array
  ld r8,[r6]
  st r8,[r9]
  add r6,r6,4
  cmp r6,r4
  bgt .mergereturn
  b .addArrayr6

.addArrayr3:
  add r9,r9,4
  ld r8,[r3]
  st r8,[r9]
  add r3,r3,4
  cmp r3,r5
  bgt .mergereturn
  b .addArrayr3

.r2inr9:
  st r2,[r9]
  add r3,r3,4
  b .merge

.swap:            @ Function To Swap Between Specific Registers
	ld r7,[r5]
	st r8,[r5]
	st r7,[r6]
	add r5,r5,4
	ret

.partition:       @ Address to the Partition of the Array
  mov r5,r4
  cmp r3,r4
  bgt .partitionReturn
  add r3,r3,4
  sub r4,r4,4
  b .partition
  .partitionReturn:
  ret



.copyArray:       @ Given Starting and Ending Address of a Array
  cmp r3,r4       @ Copy one Array to Another Memory Location
  bgt .careturn
  ld r8,[r9]
  st r8,[r3]
  add r3,r3,4
  add r9,r9,4
  b .copyArray
  .careturn:
  ret

.mergesort:
  @ Base Case
	cmp r3,r4
	bgt .msReturn
	beq .msReturn

  add r9,r9,16   @ Allocate Stack Memory And Save Pointer
  st ra,[r9]

  st r3,4[r9]    @ Get Center r5 lo = r3, hi = r4
  st r4,12[r9]
  call .partition 
  st r5,8[r9]

  ld r3,4[r9]    @ Recursion
  mov r4,r5
  call .mergesort
  ld r4,12[r9]
  ld r5,8[r9]
  add r3,r5,4
	call .mergesort

  ld r3,4[r9]    @ Merging Two Arrays
  ld r5,8[r9]
  ld r4,12[r9]
  add r6,r5,4
  call .mergeArray
 
  @ Deallocate Memory And Restore Return
  ld ra,[r9]
  sub r9,r9,16
	.msReturn:
  ret



.merge:             @ Merge -> Recursive Function To Combine Merged Arrays into One
  cmp r3,r5
  bgt .addArrayr6
  cmp r6,r4
  bgt .addArrayr3

  add r9,r9,4
  ld r2,[r3]
  ld r8,[r6]

  cmp r8,r2
  bgt .r2inr9

  st r8,[r9]
  add r6,r6,4
  b .merge

  .mergereturn:
  ret

.mergeArray:
  @ Stack Allocate
  add r9,r9,16
  mov r7,r9
  st ra,[r9]
  st r3,4[r9]
  st r5,8[r9]
  st r6,12[r9]
  st r4,16[r9]

  add r9,r9,16
  call .merge

  @ Copy The Array From r9,20 to ..
  mov r9,r7
  ld r3,4[r9]
  ld r4,16[r9]
  add r9,r7,20
  call .copyArray

  @ Stack Deallocate
  mov r9,r7
  ld ra,[r9]
  sub r9,r9,16
  ret