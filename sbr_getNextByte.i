; -----------------------------------------
; get next byte
;
; byteStreamVar+0, 		repeat counter
; byteStreamVar+1, 		repeat byte
; byteStreamVar+2,
; bytePointer,				current position in the byte stream
; -----------------------------------------
getNextByte:
	LDA byteStreamVar+0																														; repeat counter non 0?
	BEQ +newByte																																	; no -> next byte
	LDA	byteStreamVar+2																														; yes-> next question: dictionary string?
	BNE +readString																																; yes-> read string from dictionary
	LDA byteStreamVar+1																														; no -> stay on the repeat byte
	DEC byteStreamVar+0
	RTS

+newByte:
	LDY #$00
	LDA (bytePointer), Y
	JSR incrementBytePointer
	CMP #$F0
	BCS +opCode
	RTS

+opCode:
	CMP #repeatBlank
	BEQ +repeatBlank
	CMP #repeatChar
	BEQ +repeatChar
	CMP #parameter
	BEQ +numberValue
	CMP #dict
	BEQ +setDictionaryString
	CMP #targetName
	BEQ +setTargetName
	RTS

+repeatBlank:
	LDA (bytePointer), Y		; number of repeats
	STA byteStreamVar+0
	DEC byteStreamVar+0			; correct for 0 loop
	LDA #$0F
	STA byteStreamVar+1
	JMP incrementBytePointer	; tail chain

+repeatChar:
	LDA (bytePointer), Y		; number of repeats
	STA byteStreamVar+0
	DEC byteStreamVar+0			; correct for 0 loop
	JSR incrementBytePointer
	LDA (bytePointer), Y
	STA byteStreamVar+1
	JMP incrementBytePointer	; tail chain

+numberValue:
	LDA (bytePointer), Y		; index of variable in list1
	TAY
	LDA list3, Y
	JSR toBCD					; find the tile for the number (0-9)
	LDA par3
	JMP incrementBytePointer	; tail chain

+setTargetName:
	LDY targetObjectIndex
	LDA object+4, Y
	AND #%01111100
	TAY
	LDA pilotTable+0, Y
	BNE +next

+setDictionaryString:
	LDA (bytePointer), Y		; string index
	JSR incrementBytePointer

+next:
	STA byteStreamVar+2
	TAY
	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1
	LDY #$00
	LDA (pointer1), Y			; length
	STA byteStreamVar+0
	BNE +next

+readString:
	TAY
	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

+next:
	LDY #$00
	LDA (pointer1), Y			; length
	SEC
	SBC byteStreamVar+0
	TAY
	INY										; shift one to account for the length byte
	LDA (pointer1), Y			; current byte
	DEC byteStreamVar+0
	BNE +
	LDY #$00
	STY byteStreamVar+2
	RTS

incrementBytePointer:
	INC bytePointer+0
	BNE +
	INC bytePointer+1
+	RTS
