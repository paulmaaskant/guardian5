; calculate the radius and angle of
; currentObject coordinates to cursor grid pos coordinates
;
; IN currentObjectXPos, currentObjectXScreen (both destroyed)
; IN currentObjectYPos, currentObjectYScreen (both destroyed)
; IN cursorGridPos (not destroyed)
; TEMP loc1,2,3,4,5, par 1,2,3,4 (destroyed)
; OUT A = angle
; OUT Y = radius

angleToCursor:
  LDA currentObjectXPos				;
  STA par1								    ;
  LDA currentObjectXScreen		;
  STA par2								    ;
  LDA currentObjectYPos				;
  STA par3								    ;
  LDA currentObjectYScreen		;
  STA par4								    ;

  LDA cursorGridPos						; target position
  JSR gridPosToScreenPos			; target screen coordinates

	LDA par1									  ; calculate X delta
	SEC                         ; determine signed difference
	SBC currentObjectXPos
	STA currentObjectXPos
	LDA par2
	SBC currentObjectXScreen
	STA currentObjectXScreen    ; store the sign (b7) for the X delta

	BPL +continue								; now store the absolute value
	LDA currentObjectXPos				; for the X delta
	EOR #$FF										; assuming it will never be
	CLC
	ADC #$01
	STA currentObjectXPos				; more than 255

+continue:                    ; calculate Y delta
	LDA par3
	SEC
	SBC currentObjectYPos
	STA currentObjectYPos
	LDA par4
	SBC currentObjectYScreen
	STA currentObjectYScreen		; store the sign (b7) for the Y delta

	BPL +continue								; now store the absolute value
	LDA currentObjectYPos				; for the Y delta
	EOR #$FF										; assuming it will never be
	CLC
	ADC #$01
	STA currentObjectYPos				; more than 255

+continue:
  LDA currentObjectXPos				; delta X in A
  TAX													; delta X in X
  JSR multiply
  LDA par1										; dX^2 HI
  STA locVar3    ;
  LDA par2										; dX^2 LO
  STA locVar4                 ;

  LDA currentObjectYPos				; delta Y
  TAX
  JSR multiply

  CLC													; dY^2 + dX^2
  LDA par2										;
  ADC locVar4				;
  STA par2
  LDA par1
  ADC locVar3                 ;
  STA par1

  JSR squareRoot              ; A and Y = sqrt(dY^2 + dX^2) = radius !



                              ; up next: min(delta X, delta Y) / radius = sin(angle)
  LDA #0											; init
  STA par2										; for upcoming divide

  LDA currentObjectXPos				; min(delta X, delta Y)
  CMP currentObjectYPos
  BCC +continue
  ROR locVar3									; set B7 if dY >= dX
  LDA currentObjectYPos

+continue:
  STA par1										; min(dX, dY)
  TYA									        ; radius
	JSR divide                  ; min(delta X, delta Y) / radius

	LDX #0											;
	LDA par4										; sin(angle)
	BEQ +continue               ; if sin(angle) = 0 then angle = 0

-loop:
	LDA sinTable, X							; inverse sin function
	CMP par4
	INX
	BCC -loop

+continue:
	TXA                         ; angle

  BIT locVar3
	BPL +continue								; if dY >= dX then
	EOR #%00111111							; angle =  64 - angle
	CLC
	ADC #1

+continue:
	BIT currentObjectYScreen
	BPL +continue								; if dY < 0 then
	EOR #%01111111							; angle = 128 - angle
	CLC
	ADC #1

+continue:
	BIT currentObjectXScreen
	BMI +continue								; if dX < 0 then
	EOR #%11111111						  ; angle = 256 - angle
	CLC
	ADC #1

+continue:
	; A = angle
  ; Y = radius
  RTS
