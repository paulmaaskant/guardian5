state_initializeModifiers:

    LDA activeObjectGridPos
    JSR gridPosToScreenPos
    JSR clearCurrentEffects

    LDA #$54
    STA list3+30
    LDA list3+0
    ORA #$40              ; add name table position
    STA list3+31
    LDA #$55
    STA list3+32

    LDA #$60
    STA list1+0

    LDA #7
  	STA currentEffects+0

  	LDA currentObjectXPos
  	STA currentEffects+6

  	LDA currentObjectYPos
  	STA currentEffects+12

  	LDA #1
  	STA effects

    LDA #$36
    JMP replaceState
