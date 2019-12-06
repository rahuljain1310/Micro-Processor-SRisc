.main:
.encode mov r0, 0
.encode mov r1, 10	
.encode st r1, 0[r0]
.encode mov r1, 9	
.encode st r1, 4[r0]
.encode mov r1, 8  
.encode st r1, 8[r0]
.encode mov r1, 7  
.encode st r1, 12[r0]
.encode mov r1,6
.encode st r1,16[r0]
.encode mov r1,5
.encode st r1,20[r0]
.encode mov r1, 4
.encode st r1,24[r0]
.encode mov r1,3
.encode st r1,28[r0]
.encode mov r2, 0          
.encode mov r3, 7	
.encode mul r3, r3, 4
.encode add r4, r2, r3
.encode call .mergesort
.encode ld r1, 0[r0]
.end:
.encode b .end
.mergesort:		
.encode cmp r2,r4
.encode beq .return
.encode bgt .return
.encode sub sp,sp,16	
.encode add r5,r2,r4
.encode div r5,r5,8
.encode mul r5,r5,4
.encode st ra,0[sp]
.encode st r2,4[sp]		
.encode st r5,8[sp]		
.encode st r4,12[sp]	
.encode mov r4,r5		
.encode call .mergesort	
.encode ld r4,12[sp]	
.encode ld r2,8[sp]		
.encode add r2,r2,4		
.encode call .mergesort	
.encode ld r6,4[sp]		
.encode ld r7,8[sp]		
.encode ld r8,12[sp]	
.encode call .merge		
.encode ld ra,0[sp]		
.encode add sp,sp,16	
.return:
.encode ret
.merge: 				
.encode sub r9,r8,r6
.encode add r9,r9,4		
.encode sub r10,sp,4	
.encode mov r11,r6		
.copy1:			
.encode cmp r6,r7
.encode bgt .endCopy1
.encode ld r12,0[r6]
.encode st r12,0[r10]
.encode sub r10,r10,4
.encode add r6,r6,4
.encode b .copy1
.endCopy1:
.copy2:			
.encode cmp r6,r8
.encode bgt .endCopy2
.encode ld r12,0[r6]
.encode st r12,0[r10]
.encode sub r10,r10,4
.encode add r6,r6,4
.encode b .copy2
.endCopy2:
.encode mov r6,r11		
.encode sub r10,sp,4	
.encode sub r7,r7,r6	
.encode sub r11,r10,r7	
.encode sub r12,r11,4	
.encode sub r9,r9,4
.encode sub r13,r10,r9	
.loop1:
.encode cmp r11,r10
.encode bgt .endloop1	
.encode cmp r13,r12
.encode bgt .endloop1	
.encode ld r7,0[r10]
.encode ld r8,0[r12]
.encode cmp r7,r8
.encode bgt .label
.encode st r7,0[r6]		
.encode add r6,r6,4
.encode sub r10,r10,4
.encode b .loop1
.label:		    
.encode st r8,0[r6]
.encode add r6,r6,4
.encode sub r12,r12,4
.encode b .loop1
.endloop1:
.loop2:			
.encode cmp r11,r10
.encode bgt .endloop2
.encode ld r7,0[r10]
.encode st r7,0[r6]
.encode add r6,r6,4
.encode sub r10,r10,4
.encode b .loop2
.endloop2:
.loop3:			
.encode cmp r13,r12
.encode bgt .endloop3
.encode ld r8,0[r12]
.encode st r8,0[r6]
.encode add r6,r6,4
.encode sub r12,r12,4
.encode b .loop3
.endloop3:
.encode ret
