; -----------------------------------------
; NOT USED anymore, kept for reference purposes
; the rule enforcing the firing arc of 120 degrees is removed from the game
;
; is target in firing arc?
;
; - firing arc always spans 120 degrees
; - facing directions always are aligned with the X, Y & Z axis
;
; algorithm
; using the firing node as the origin, the target is within the
; firing arc if it is within the sextant left or right of the axis
; that aligns with the facing direction
;
; to determine this locVar5 is created first:
;
; bbbbbbbb
; ||||||||
; |||||||+ 1: Z target <= Z source
; ||||||+- 1: Z target >= Z source
; |||||+-- 1: Y target <= Y source
; ||||+--- 1: Y target >= Y source
; |||+---- 1: X target <= X source
; ||+----- 1: X target >= X source
; ++------ not used
;
; -----------------------------------------
checkFiringArc:
	LDA cursorGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar2									; target grid Y
	LDA cursorGridPos
	AND #$0F										; x mask
	STA locVar1									; target grid X

	LDA activeObjectGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar4									; firing unit grid Y
	LDA activeObjectGridPos
	AND #$0F										; x mask
	STA locVar3									; firing unit grid X

	LDA locVar1
	CMP locVar3
	ROL locVar5

	LDA locVar3
	CMP locVar1
	ROL locVar5

	LDA locVar2
	CMP locVar4
	ROL locVar5

	LDA locVar4
	CMP locVar2
	ROL locVar5

	LDA locVar1
	CLC
	ADC locVar2
	STA locVar1

	LDA locVar3
	CLC
	ADC locVar4
	STA locVar3

	LDA locVar1
	CMP locVar3
	ROL locVar5

	LDA locVar3
	CMP locVar1
	ROL locVar5

	LDY activeObjectIndex
	LDA object, Y
	AND #$07
	TAY
	LDA fireArc-1, Y	;
	AND locVar5			;
	CMP fireArc-1, Y
	BEQ +
	CLC								; clear if not in firing arc
+	RTS

fireArc:
	.db %00011000		;1 Xt<, Yt>
	.db %00001010		;2 Yt>, Zt>
	.db %00100010		;3 Xt>, Zt>
	.db %00100100		;4 Yt<, Xt>
	.db %00000101		;5 Yt<, Zt<
	.db %00010001		;6 Xt<, Zt<
