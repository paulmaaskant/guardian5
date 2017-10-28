runExplosion:

  LDA effects
  ORA #$04
  STA effects

  LDA cursorGridPos
  JSR gridPosToScreenPos

  INC actionCounter

  LDA #$05
  STA currentEffects+0                ; animation
  STA currentEffects+1
  STA currentEffects+2
  STA currentEffects+3

  LDA currentObjectXPos
  CLC
  ADC actionCounter
  STA currentEffects+6
  STA currentEffects+8

  LDA currentObjectXPos
  SEC
  SBC actionCounter
  STA currentEffects+7
  STA currentEffects+9

  ; Y

  LDA currentObjectYPos
  CLC
  ADC actionCounter
  STA currentEffects+12
  STA currentEffects+13

  LDA currentObjectYPos
  SEC
  SBC actionCounter
  STA currentEffects+14
  STA currentEffects+15

  LDA #0
  STA currentEffects+24
  STA currentEffects+25
  STA currentEffects+26
  STA currentEffects+27

  RTS
