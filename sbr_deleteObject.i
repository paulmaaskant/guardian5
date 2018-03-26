; --------------------------
; deleteObject
; in A, objectTypeAndNumber to be deleted
; --------------------------
deleteObject:
	LDX objectListSize
	DEX

	; --- first find the to-be deleted object ---
-loop:
	CMP objectList, X
	BEQ +continue
	DEX
	BPL -loop
	RTS

	; --- then delete it ---
+continue:
	AND #%01111000							; retrieve object's grid pos
	TAY
	LDA object+3, Y
	TAY
	LDA nodeMap, Y							; so that it can be be unblocked
	AND #$3F
	STA nodeMap, Y
	DEC objectListSize						; reduce the object count by 1

-loop:														; and remove the 'empty' spot in the object list
	CPX objectListSize								; by moving each object behind the removed object by one spot
	BEQ +done
	LDA objectList+1, X
	STA objectList, X
	INX
	BNE -loop												;

+done:
	RTS
