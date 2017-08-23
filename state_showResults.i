; ------------------------------------------
; gameState 16: shows the results of an action in the action menu, waiting for user confirmation
; ------------------------------------------
;
; list1+0..9	Reserved for Run Dialog state
; list2+0..9  Reserved for lightflash
;
; list3+0		Temp value
; list3+1		Hit Probability
; list3+2		Damage value
; list3+3		stream 1
; list3+4		stream 2
; list3+5		stream 3
; list3+6..9 reserve for streams
;
; list3+10		Hit probability sprite x_
; list3+11		Hit probability sprite _x
; list3+20		target click value

state_showResults:
	LDX #$00
-	LDA list3+3, X				; get next op code
	BNE +continue					; not zero >
	INX										; otherwise try next
	CPX #$06
	BNE -									; all dialogs done
	LDA #$08							; next turn
	STA gameState
	RTS

+continue:
	BPL +startDialog			; any opcode with b7=1 triggers a flash
	LDA #$00							; opcode processed
	STA list3+3, X
	LDA #$16							; --- set light FLASH parameters ---
	STA list1+0						; return to this game state when done
	LDA #$00
	STA list1+1						; flash toggle
	LDA #$1C							; game state "light flash"
	STA gameState					; next gamestate
	LDA targetObjectTypeAndNumber
	JMP deleteObject			; tail chain

+startDialog:
	TAY
	LDA #$00							; opcode processed
	STA list3+3, X				;
	LDA streamHi-1, Y
	STA bytePointer+0
	LDA streamLo-1, Y
	STA bytePointer+1
	LDA #$24
	STA list1+0						; start address hi
	STA list1+2						;
	LDA #$4A
	STA list1+1						; start address lo
	STA list1+3						;
	LDA #$0A
	STA list1+4						; # tiles: offset
	LDA #$17
	STA list1+5						; # tiles: last pos
	LDA #$00
	STA list1+6						; stream on
	LDA #$16
	STA list1+8						; goal state: show results
	LDA #$09
	STA gameState					; game state
	RTS

streamHi:
	.db #< resultTargetHit									; 1
	.db #< resultTargetMiss									; 2
	.db #< resultTempStable									; 3
	.db #< resultTempDecrease								; 4
	.db #< resultUnitDestroyed							; 5
	.db #< resultChargeDamageSustained			; 6
streamLo:
	.db #> resultTargetHit
	.db #> resultTargetMiss
	.db #> resultTempStable
	.db #> resultTempDecrease
	.db #> resultUnitDestroyed
	.db #> resultChargeDamageSustained
