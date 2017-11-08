; --------------------------
; deleteObject
; in A, objectTypeAndNumber to be deleted
; --------------------------
deleteObject:
	LDX #$05

	; --- first find the to-be deleted object ---
-loop:
	CMP objectTypeAndNumber, X
	BEQ +continue
	DEX
	BPL -loop
	RTS

	; --- then delete it ---
+continue:
	AND #$07										; retrieve object's grid pos
	ASL
	ASL
	TAY
	LDA object+3, Y
	TAY
	LDA nodeMap, Y							; so that it can be be unblocked
	AND #$3F
	STA nodeMap, Y
	DEC objectCount							; reduce the object count by 1

-loop:														; and remove the 'empty' spot in the object list
	CPX objectCount									; by moving each object behind the removed object by one spot
	BEQ +done
	LDA objectTypeAndNumber+1, X
	STA objectTypeAndNumber, X
	INX
	BNE -loop												;

+done:
	RTS
