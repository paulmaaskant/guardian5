; -----------------------------------------------
; game state 2E: resolve ranged attack (machine gun)
; -----------------------------------------------
; list1+00, frame counter
; list1+02, loop control
; list1+03, temp
; list1+07, radius
; list1+08, angle




state_resolveMissile:
  LDA activeObjectGridPos
  JSR gridPosToScreenPos      ; sets currentObject coordinats


  LDA #1
  STA list1+2


-loop:
  LDA currentObjectYPos
  CLC
  ADC #-10
  STA currentObjectYPos

  LDY list1+2
  LDA list1+0
  LSR
  CLC
  ADC state_2E_offset, Y
  AND #$1F                    ; 0-32
  PHA
  TAY                         ; index for radius and angle

  LDX state_2E_radius, Y
  LDA list1+7
  JSR multiply
  LDA par1
  TAX

  LDA list1+2
  LSR                         ; set carry
  PLA
  TAY
  LDA state_2E_angle, Y
  BCC +continue               ; use carry
  EOR #$FF

+continue:
  ADC list1+8

  JSR getCircleCoordinates
  TXA
  CLC
  LDX list1+2
  ADC currentObjectXPos
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentObjectYPos
  STA currentEffects+12, X

  LDA #$20												; animation #
  STA currentEffects+0, X

  DEC list1+2
  BPL -loop

  LDA list1+0
  CMP #160								; runs for 128 frames
  BEQ +done

  ;CLC											; not really ncessary as long as max is 128 frames
  ADC #1
  STA list1+0
  RTS

; ------------------------------------------------
; animation completed , prepare for transition
; ------------------------------------------------
+done:
  LDA #$00						; switch off all blinking
  STA menuFlags
  JMP pullState

state_2E_angle:
.db 96
.db 96
.db 96
.db 96
.db 96
.db 96
.db 96
.db 96
.db 92
.db 88
.db 84
.db 80
.db 76
.db 72
.db 68
.db 64
.db 60
.db 56
.db 52
.db 48
.db 44
.db 40
.db 36
.db 32
.db 28
.db 24
.db 20
.db 16
.db 12
.db 8
.db 4
.db 0


state_2E_radius:
.db 3
.db 5
.db 8
.db 10
.db 13
.db 15
.db 18
.db 20
.db 23
.db 26
.db 28
.db 31
.db 33
.db 36
.db 38
.db 41
.db 54
.db 64
.db 67
.db 69
.db 72
.db 84
.db 96
.db 109
.db 118
.db 128
.db 141
.db 154
.db 179
.db 205
.db 230
.db 255


state_2E_offset
.db 0
.db 16

state_2E_side
.db 0
.db $FF
