eff_blast:

LDA effects
ORA #$04
STA effects

LDA cursorGridPos
JSR gridPosToScreenPos

INC runningEffectCounter

LDA currentObjectXPos
CLC
ADC runningEffectCounter
STA currentEffects+6
STA currentEffects+8

CMP #$F8
BNE +continue

LDA #$0B
STA currentEffects+0               ; hide
STA currentEffects+2

+continue:
LDA currentObjectXPos
SEC
SBC runningEffectCounter
STA currentEffects+7
STA currentEffects+9

CMP #$08
BNE +continue

LDA #$0B
STA currentEffects+1               ; hide
STA currentEffects+3

+continue:
; Y

LDA currentObjectYPos
CLC
ADC runningEffectCounter
ADC #-8
STA currentEffects+12
STA currentEffects+13

CMP #$E0
BNE +continue

LDA #$0B
STA currentEffects+0               ; hide
STA currentEffects+1

+continue:

LDA currentObjectYPos
SEC
SBC runningEffectCounter
SBC #8
STA currentEffects+14
STA currentEffects+15

CMP #$30
BNE +continue

LDA #$0B
STA currentEffects+2               ; hide
STA currentEffects+3

+continue:

LDA #$00
STA currentEffects+24
STA currentEffects+26

LDA #$40
STA currentEffects+25
STA currentEffects+27

LDX #3

-loop:
  LDA currentEffects, X
  CMP #$0B
  BNE +done
  DEX
  BPL -loop

  LDA #0
  STA runningEffect
  DEC cameraYDest+1

+done:
  RTS
