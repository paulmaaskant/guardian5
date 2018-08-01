state_initializeTargetObjectHeatMarker:
    LDA cursorGridPos
    JSR gridPosToScreenPos
    JSR clearCurrentEffects

    LDA #$54
    STA list3+30
    LDA list3+13
    ORA #$40              ; add name table position
    STA list3+31
    LDA #$57
    STA list3+32

    LDA #100
    STA runningEffectCounter

    LDA #7
    STA currentEffects+0

    LDA currentObjectXPos
    STA currentEffects+6

    LDA currentObjectYPos
    STA currentEffects+12

    LDA #2
    STA runningEffect
    JMP pullState
