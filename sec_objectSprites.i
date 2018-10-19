  LDX #0													; start with object on pos 0

-loopObjects:
  LDA objectList, X								; get next object
  AND #%01111000									; object index
  TAY
  STY locVar1											;

  LDA object+0, Y									; get the object's type
  LSR															;
  LSR															;
  LSR															;
  LSR															;
  TAY															; and store it in Y
  LDA objectTypeL, Y							; get the object type data address
  STA currentObjectType+0
  LDA objectTypeH, Y
  STA currentObjectType+1					; and store it as the current object type

  LDY locVar1											; restore object's index
  TXA															;
  PHA															; save X (object iteration)
  TYA															;
  PHA															; save Y (object index) on stack

  LDA object+2, Y									; retrieve
  AND #%00111111									; object's counter
  STA currentObjectFrameCount			; make it the current counter

  LDA object+3, Y									; get screen coordinates and see if object is visible
  JSR gridPosToScreenPos					; get and set screen X & Y
  BCC +done												; off screen -> done (no need to show sprites)

  LDY #11                         ; movement stats
  LDA (currentObjectType), Y
  BPL +skip											  ; check if hovering

  LDA frameCounter								; hover effect
  AND #%01100000                  ;
  LSR
  LSR
  LSR
  LSR
  LSR
  CMP #3
  BNE +add
  LDA #0

+add:
  ADC currentObjectYPos
  STA currentObjectYPos           ; apply hover offset

+skip:
  PLA
  TAY
  PHA

  LDA object+0, Y									; check if the object is moving
  AND #%00001000									; if object move bit (b3) is set
  BEQ +continue										; not moving-> continue

  LDA list3+63
  STA currentObjectYPos

  LDA list3+62
  STA currentObjectXPos

+continue:												  ; next, determine mirror, palette & which animation
  LDA object+0, Y
  AND #$07
  CMP #7
  BEQ +done                         ; hide sprites for object with direction 7

  LDA object+0, Y
  PHA															  ; temp store for possible movement animation
  AND #$07 								          ; direction = index
  TAY

  LDA mirrorTable, Y
  STA par4													; par4 (b7-6 no mirror, b5 no mask, b4 not obscured, b0 no palette flip)
  LDA directionLookup, Y
  TAY
  LDA (currentObjectType), Y 				; retrieve sequence from the type
  TAY																; IN parameter Y = animation sequence
  JSR loadAnimationFrame						; breaks every variable

  PLA                               ; retrieve to check if object is moving
  AND #%00001000
  BEQ +notMoving
  LDA list3+61                      ; movement amimation, set by resolving state
  CMP #16
  BCS +direct
  TAY
  LDA (currentObjectType), Y 				; retrieve sequence from the type

+direct:
  TAY																; IN parameter Y = animation sequence
  JSR loadAnimationFrame						; breaks every variable

+notMoving:
  INC currentObjectFrameCount				;

+done:
  PLA																; restore Y
  TAY																; from the stack
  PLA																; restore X
  TAX
  LDA object+2, Y
  AND #%11000000										; save b7 (??) b6 (turn)
  ORA currentObjectFrameCount				; object frame count
  STA object+2, Y
  INX																; next object
  CPX objectListSize								; number of objects presently in memory
  BEQ +continue
  JMP -loopObjects									;

+continue:
