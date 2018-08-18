;
; ----------------------------------------------------------
; state 35: +/- heat point marker on active unit
; ----------------------------------------------------------
state_initializeActiveObjectHeatMarker:
    LDA activeObjectGridPos
    JSR gridPosToScreenPos
    JSR clearCurrentEffects

    LDX #$54
    LDA list3+12
    BEQ +noMarker
    BPL +positive
    LDX #$56
    STX list3+30

+positive:
    JSR absolute
    ORA #$40              ; add name table position
    STA list3+31
    LDA #$57
    STA list3+32

    LDA #80
    STA runningEffectCounter

    LDA #7
  	STA currentEffects+0

  	LDA currentObjectXPos
  	STA currentEffects+6

  	LDA currentObjectYPos
  	STA currentEffects+12

  	LDA #2
  	STA runningEffect
    
+noMarker:
    JMP pullState
