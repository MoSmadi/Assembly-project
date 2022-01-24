include inout.asm
.model  small,c
.486
.stack  2000
.code


proc shift   _number:word     ;_number : Number of line
	locals
	uses ax,bx,cx,si,di,es
	
			mov     ah,0h
			mov     al,3+128
			int     10h
			
			mov     cx,80
			mov     bx,0b800h
			
			mov     es,bx
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Calculat number of the first character in the row and make (si) point on it;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

			xor 	ax,ax
			mov 	ax,_number
			imul 	ax,160
			sub 	ax,160
			mov     si,ax
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Calculat number of the last character in the row and make (di) point on it;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			xor     ax,ax
			mov     ax,_number
			imul    ax,160
			dec     ax
			dec     ax
			mov     di,ax


			push    ds
			mov     bx,0b800h
			mov     ds,bx
		

	again:
			movsw
					
;Compare if (di) stay less than the final character in the row

			xor 	ax,ax
			mov 	ax,_number
			imul 	ax,160
			cmp 	di,ax
			jl 		not_end
					
;else return the pointer to the first character of the row	
				
			xor 	ax,ax
			mov 	ax,_number
			imul 	ax,160
			sub 	ax,160
			
			mov     di,ax
					
	
	not_end:    	

;Compare if (si) stay less than the final character in the row	
			
			xor 	ax,ax
			mov		ax,_number
			imul 	ax,160
			cmp 	si,ax
			jl 		not_endofline
					
;else return the pointer to the first character of the row
	
			xor 	ax,ax
			mov 	ax,_number
			imul 	ax,160
			sub 	ax,160
				
			mov     si,ax

	
	
	not_endofline:
	
			loop again
					
			pop	 ds
	

	ret
shift endp


proc delay
	locals
	uses cx 
	
			mov cx,65000
			again1:
			nop
			nop
			loop again1
	
	ret
delay endp


.STARTUP
next:
call shift,1
call shift,2
call shift,3
call shift,4
call shift,5
call shift,6
call shift,7
call shift,8
call shift,9
call shift,10
call shift,11
call shift,12
call shift,13
call shift,14
call shift,15
call shift,16
call shift,17
call shift,18
call shift,19
call shift,20
call shift,21
call shift,22
call shift,23
call shift,24
call shift,25
call delay
jmp next
	
	.EXIT
END