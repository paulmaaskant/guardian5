; list1+0 direction
; list1+1 moving

state_playAnimation:

  LDA #$00
  STA pal_transparant

  ;LDA #$0
  ;JSR updatePalette

  LDA blockInputCounter
	BEQ +continue
	DEC blockInputCounter
	JMP +showSprite

+continue:
  LDA buttons
  BNE +continue
  STA list1+1           ; no longer moving
  JMP +showSprite

+continue:
  LSR                   ; right
  BCC +continue
  INC currentObjectFrameCount
  ;INC list1+0
  ;LDY list1+0
  ;CPY #$06
  ;BNE +setTimer
  ;LDY #$00
  ;STY list1+0

+continue:
  LSR                   ; left
  BCC +continue
  DEC list1+0
  BPL +setTimer
  LDY #$05
  STY list1+0

+continue:
  LSR                   ; skip down
  LSR                   ; skip up
  LSR                   ; skip start
  BCC +continue


	JSR buildStateStack
	.db $05								; # stack items
  .db $2C
	.db $0D, 2						; change brightness 2: flash out
	.db $0D, 3						; change brightness 3: flash out
	; built in RTS

+continue:
  LSR                   ; select
  BCC +continue
  JMP pullState         ; back to main menu

+continue:
  LSR                   ; B
  BCC +continue

  INC list1+2
  LDY list1+2
  CPY #$04
  BNE +setTimer
  LDY #$01
  STY currentObjectFrameCount
  STY list1+2

+continue:
  LSR                   ; A
  BCC +setTimer

  LDA #$04
  STA list1+1

+setTimer:
	LDA #$08
	STA blockInputCounter

  LDY list1+0
  LDA state26_mirror, Y
  STA par4

  LDA #1
  STA par3

+showSprite:
  LDA #$80
  STA currentObjectYPos
  STA currentObjectXPos

  LDY list1+2
  LDA objectTypeL, Y
  STA currentObjectType+0
  LDA objectTypeH, Y
  STA currentObjectType+1

  LDY list1+0
  LDA state26_direction, Y
  CLC
  ADC list1+1
  TAY
  LDA (currentObjectType), Y 																										; retrieve sequence from the type
	TAY
  LDY #$1D																																	   ; IN parameter Y = animation sequence
  JSR loadAnimationFrame
	INC currentObjectFrameCount
  RTS

state26_mirror:
  .db 0, 64, 64, 0, 0, 0
state26_direction:
  .db 0, 1, 2, 3, 2, 1
